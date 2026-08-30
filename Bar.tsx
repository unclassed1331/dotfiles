import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import { Variable, bind, execAsync } from "astal"
import Hyprland from "gi://AstalHyprland"
import Battery from "gi://AstalBattery"
import Network from "gi://AstalNetwork"
import Bluetooth from "gi://AstalBluetooth"
import Wp from "gi://AstalWp"
import GLib from "gi://GLib"

const time = Variable("").poll(1000, ["bash", "-c", "TZ=America/Edmonton date '+%I:%M %p'"])
const brightness = Variable(0).poll(2000, ["bash", "-c", "brightnessctl -m | cut -d, -f4 | tr -d '%'"])
const fullDate = Variable("").poll(60000, ["bash", "-c", "TZ=America/Edmonton date '+%A, %B %d, %Y'"])
const loadAvg = Variable("").poll(2000, ["bash", "-c", "uptime | awk -F'load average:' '{print $2}' | xargs"])
const ramDetail = Variable("").poll(2000, ["bash", "-c", "free -h | awk '/Mem:/ {print $3\"/\"$2}'"])
const powerMode = Variable("").poll(5000, ["bash", "-c", "tlp-stat -m"])


function CpuLabel() {
    const cpu = Variable("0").poll(2000, ["bash", "-c", "top -bn1 | grep 'Cpu(s)' | awk '{print 100 - $8}' | cut -d. -f1"])
    const temp = Variable("0").poll(2000, ["bash", "-c", "sensors | awk '/Package id 0/ {print $4}' | tr -d '+°C'"])

    return <button
        className="cpu-btn"
        tooltipText={temp().as(t => `Temp: ${t}°C`)}
        onClicked={() => execAsync("gnome-system-monitor").catch(print)}
    >
        <label label={bind(cpu).as(v => `󰻠 ${v}%`)} />
    </button>
}


function RamLabel() {
    const ram = Variable("0").poll(2000, ["bash", "-c", "free -m | awk '/Mem:/ {printf \"%d\", $3/$2*100}'"])

    return <button
        className="ram-btn"
        tooltipText={ramDetail().as(r => `Used: ${r}`)}
        onClicked={() => execAsync("gnome-system-monitor").catch(print)}
    >
        <label label={bind(ram).as(v => `󰸏 ${v}%`)} />
    </button>
}


function Workspaces() {
    const hypr = Hyprland.get_default()

    return <box className="Workspaces">
        {bind(hypr, "workspaces").as(wss =>
            wss
                .filter(ws => ws.id > 0)
                .sort((a, b) => a.id - b.id)
                .map(ws => (
                    <button
                        className={bind(hypr, "focusedWorkspace").as(fw =>
                            `ws-${ws.id}${fw?.id === ws.id ? " ws-active" : ""}`
                        )}
                        onClicked={() => execAsync(["bash", "-c", `hyprctl dispatch 'hl.dsp.focus({ workspace = ${ws.id} })'`]).catch(print)}                    >
                        {ws.id}
                    </button>
                ))
        )}
    </box>
}

function WifiLabel() {
    const network = Network.get_default()
    const wifi = network.get_wifi()

    if (!wifi) return <label label="󰤭" />

    return <button
        className="wifi-btn"
        tooltipText={bind(wifi, "ssid").as(ssid =>
            ssid ? `${ssid} (${wifi.strength}%)` : "Not connected"
        )}
        onClicked={() => execAsync("nm-connection-editor").catch(print)}
    >
        <label label={bind(wifi, "ssid").as(ssid => ssid ? "󰤨" : "󰤭")} />
    </button>
}

function BluetoothLabel() {
    const bt = Bluetooth.get_default()

    return <button
        className="bt-btn"
        tooltipText={bind(bt, "isPowered").as(on => on ? "Bluetooth: on" : "Bluetooth: off")}
        onClicked={() => execAsync("blueman-manager").catch(print)}
    >
        <label label={bind(bt, "isPowered").as(on => on ? "󰂯" : "󰂲")} />
    </button>
}

function VolumeLabel() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker
    const hovered = Variable(false)

    if (!speaker) return <label label="No Audio" />

    return <eventbox
        onHover={() => hovered.set(true)}
        onHoverLost={() => hovered.set(false)}
    >
        <box>
            <button className="volume-btn" onClicked={() => execAsync("pavucontrol").catch(print)}>
                <label label={bind(speaker, "volume").as(v => `󰕾 ${Math.round(v * 100)}%`)} />
            </button>
            <revealer revealChild={hovered()} transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}>


<slider
    widthRequest={100}
    min={0}
    max={1.5}
    value={bind(speaker, "volume")}
    onValueChanged={(self) => speaker.set_volume(self.value)}
/>

             

            </revealer>
        </box>
    </eventbox>
}


function BrightnessLabel() {
    const hovered = Variable(false)
    let sliderRef: Gtk.Scale | null = null
    let seeded = false
    let debounceTimer: number | null = null

    return <eventbox
        onHover={() => {
            if (sliderRef && !seeded) {
                sliderRef.value = Number(brightness.get())
                seeded = true
            }
            hovered.set(true)
        }}
        onHoverLost={() => hovered.set(false)}
    >
        <box>
            <button
                className="brightness-btn"
                onClicked={() => execAsync(["bash", "-c", "XDG_CURRENT_DESKTOP=GNOME gnome-control-center display"]).catch(print)}
            >
                <label label={brightness().as(b => `󰃟 ${b}%`)} />
            </button>
            <revealer revealChild={hovered()} transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}>
                <slider
                    setup={(self) => { sliderRef = self }}
                    widthRequest={100}
                    min={0}
                    max={100}

onButtonReleaseEvent={(self) => {
    const v = Math.round(self.value)
    execAsync(["bash", "-c", `brightnessctl set ${v}%`]).catch(print)
    return false
}}
                />
            </revealer>
        </box>
    </eventbox>
}

function BatteryLabel({ bat }: { bat: Battery.Device }) {
    return <button
        className="battery-btn"
        visible={bind(bat, "isPresent")}
        tooltipText={powerMode().as(m => `Mode: ${m}`)}
        onClicked={() => execAsync(["bash", "-c", "XDG_CURRENT_DESKTOP=GNOME gnome-control-center power"]).catch(print)}
    >
        <label label={bind(bat, "percentage").as(p => {
            const pct = Math.round(p * 100)
            let icon = "󰁹"
            if (pct <= 10) icon = "󰂎"
            else if (pct <= 30) icon = "󰁻"
            else if (pct <= 50) icon = "󰁽"
            else if (pct <= 70) icon = "󰂀"
            else if (pct <= 90) icon = "󰂂"
            return `${icon} ${pct}%`
        })} />
    </button>
}



export default function Bar(gdkmonitor: Gdk.Monitor) {
    const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
    const bat = Battery.get_default()

    return <window
        className="Bar"
        gdkmonitor={gdkmonitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | RIGHT}
        application={App}>

            <overlay>
    <box className="bar-bg">
        <box halign={Gtk.Align.START} spacing={250}>
            <box>
                <Workspaces />
            </box>
            <box>
                <CpuLabel />
                <RamLabel />
            </box>
        </box>
        <box halign={Gtk.Align.END} hexpand spacing={4}>
            <BluetoothLabel />
            <WifiLabel />
            <BrightnessLabel />
            <VolumeLabel />
            <BatteryLabel bat={bat} />
        </box>
    </box>
    
<eventbox halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER} tooltipText={fullDate()}>
    <label className="clock-label" label={time()} />
</eventbox>



</overlay>
    </window>
}
