import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import EasyAudioTool 1.0

Window {
    id: root
    width: 800
    height: 500
    visible: true

    ListView {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10

        model: [
            './audio/audio.flac',
            './audio/audio.mp3',
            './audio/audio.wav',
            './audio/weixin.amr'
        ]

        delegate: Rectangle {
            width: ListView.view.width
            height: 70
            radius: 4
            border.color: "gray"

            EasyAudioPlayer {
                id: player
                filepath: modelData
                property real duration: 0
                Component.onCompleted: {
                    player.duration = player.getDuration();
                }
                onPositionChanged: {
                    if(!slider.pressed){
                        slider.value = position;
                    }
                }
            }

            //测试流程
            Row {
                x: 20
                y: 10
                spacing: 10
                Text {
                    width: 200
                    elide: Text.ElideRight
                    text: "path:"+player.filepath
                }
                Text {
                    width: 120
                    elide: Text.ElideRight
                    text: "pos:"+player.position
                }
                Text {
                    width: 120
                    elide: Text.ElideRight
                    text: "len:"+player.duration
                }
                Button {
                    text: player.onPlaying ? "pause" : "play"
                    onClicked: {
                        if(player.onPlaying){
                            //暂停播放
                            player.pause();
                        }else{
                            //播放或者暂停后继续
                            player.play();
                        }
                    }
                }
                Button {
                    text: "stop"
                    onClicked: {
                        //停止
                        player.stop();
                    }
                }
            }

            Slider {
                id: slider
                x: 20
                width: 400
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                from: 0
                to: player.duration
                //value: player.position
                onPressedChanged: {
                    if(!pressed){
                        //console.log('seek',value)
                        player.seek(value)
                    }
                }
            }
        }
    }
}
