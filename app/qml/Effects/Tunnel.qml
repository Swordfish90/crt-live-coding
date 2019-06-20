import QtQuick 2.0

import "../utils.js" as Utils

ShaderEffect {
    id: effect

    property color fontColor: appSettings.fontColor

    Connections {
        target: oscData
        onNewData: {
            effect.loud = loud / 100
            effect.speed = Utils.lint(0.01, 0.20, effect.loud * effect.loud)
        }
    }

    property real loud: 0

    property size resolution: Qt.size(width, height)

    property real time: 0

    property real speed: 0

    Connections {
        target: timeManager
        onTimeChanged: time += effect.speed
    }

    anchors.fill: parent
    blending: false


    fragmentShader: "
        #define CIRCLES 8.0
        #ifdef GL_ES
            precision mediump float;
        #endif

        uniform highp float qt_Opacity;
        uniform highp float time;
        varying highp vec2 qt_TexCoord0;

        uniform highp vec4 fontColor;
        uniform mediump vec2 resolution;

        uniform mediump float loud;

        vec2 position(float z) {
            float temp1 = cos(z * 0.031) * 4.0;
            float temp2 = sin(z * 0.0091) * 3.0;
            return vec2(
                sin(z * 0.1) + sin(temp1) + sin(temp2) * 3.0,
                cos(z * 0.1) + cos(temp1) + cos(temp2) * 3.0
            );
        }" +

        "void main() {
            vec2 p = (qt_TexCoord0 * resolution * 2.0 - resolution) / min(resolution.x, resolution.y);
            float speed = 1.0;
            float camZ = speed * time;
            vec2 cam = position(camZ);

            float dt = 0.5;
            float camZ2 = speed * (time + dt);
            vec2 cam2 = position(camZ2);
            vec2 dcamdt = (cam2 - cam) / dt;

            vec3 f = vec3(0.0);
            for(float i = 1.0; i < CIRCLES; i += 1.0) {
                float realZ = floor(camZ) + i;
                float screenZ = realZ - camZ;
                float r = 0.5 / screenZ;
                vec2 c = (position(realZ) - cam) * 4.0 / screenZ - dcamdt * 0.4;
                vec3 color = (vec3(sin(realZ * 0.07), sin(realZ * 0.1), sin(realZ * 0.08)) * 0.25 + vec3(1.00)) / 2.0;
                f += color * 0.06 / screenZ / (abs(length(p - c) - r) + 0.01) * smoothstep(1.0, 0.0, screenZ / CIRCLES);
            }

            f = f * fontColor.rgb * loud;
            f = clamp(vec3(0.0), vec3(0.5), f);

            gl_FragColor = vec4(f, qt_Opacity);" +
        "}"

     onStatusChanged: {
         // Print warning messages
         if (log)
             console.log(log);
     }
}
