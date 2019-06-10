import QtQuick 2.0

ShaderEffect {
    id: effect

    property color fontColor: appSettings.fontColor

    Connections {
        target: oscData
        onNewData: {
            effect.loudIntegral += (loud / 100)
            effect.loud = loud / 100
        }
    }

    property real loud: 0
    property real loudIntegral: 0

    property size resolution: Qt.size(width, height)

    property real time: timeManager.time

    anchors.fill: parent
    blending: false


    fragmentShader: "
        #ifdef GL_ES
            precision mediump float;
        #endif

        #define pi 3.14159265

        uniform highp float qt_Opacity;
        uniform highp float time;
        varying highp vec2 qt_TexCoord0;

        uniform highp vec4 fontColor;
        uniform mediump vec2 resolution;

        uniform lowp float loud;
        uniform highp float loudIntegral;

        vec3 hsv2rgb(in vec3 hsv) {
            hsv.yz = clamp (hsv.yz, 0.0, 1.0);
            return hsv.z * (1.0 + 0.5 * hsv.y * (cos (2.0 * pi * (hsv.x + vec3 (0.0, 2.0 / 3.0, 1.0 / 3.0))) - 1.0));
        }

        float rand(in vec2 seed) {
            return fract(sin(dot(seed, vec2 (12.9898, 78.233))) * 137.5453);
        }
        " +

        "void main() {
            vec2 frag = (2.0 * qt_TexCoord0 * resolution - resolution) / resolution.y;
            frag *= 5.0;
            float random = rand(floor(frag));
            vec2 black = smoothstep(1.0, 0.8, cos(frag * pi * 2.0));
            vec3 color = hsv2rgb(vec3(random, 1.0, 1.0));
            color *= black.x * black.y * smoothstep(1.0, 0.0, length(fract(frag) - 0.5));
            color *= 0.5 + loud * cos(random + random * time + 0.125 * pi * loudIntegral);
            color *= 0.5;

            gl_FragColor = vec4(color * fontColor.rgb, qt_Opacity);" +
        "}"

     onStatusChanged: {
         // Print warning messages
         if (log)
             console.log(log);
     }
}
