import QtQuick 2.0

ShaderEffect {
    id: effect

    property color fontColor: appSettings.fontColor

    Connections {
        target: oscData
        onNewData: {
            effect.speed = loud / 1000
            effect.loudness = loud / 100
        }
    }

    property real loudness: 0

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

        uniform mediump float loudness;
        uniform mediump float flatness;

        uniform lowp float pw0;
        uniform lowp float pw1;
        uniform lowp float pw2;
        uniform lowp float pw3;
        uniform lowp float pw4;
        uniform lowp float pw5;
        uniform lowp float pw6;
        uniform lowp float pw7;

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
                vec3 color = (vec3(sin(realZ * 0.07), sin(realZ * 0.1), sin(realZ * 0.08)) + vec3(1.00)) / 2.0;
                f += color * 0.06 / screenZ / (abs(length(p - c) - r - flatness) + 0.01) * smoothstep(1.0, 0.0, screenZ / CIRCLES);
            }

            f = f * fontColor.rgb * loudness;

            gl_FragColor = vec4(f, qt_Opacity);" +
        "}"

     onStatusChanged: {
         // Print warning messages
         if (log)
             console.log(log);
     }
}
