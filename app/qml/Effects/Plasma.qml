import QtQuick 2.0

ShaderEffect {
    id: effect

    property color fontColor: appSettings.fontColor

    Connections {
        target: oscData
        onNewData: {
            effect.loudness = loud / 100
            effect.pw0 = pw0
            effect.pw1 = pw1
            effect.pw2 = pw2
            effect.pw3 = pw3
            effect.pw4 = pw4
            effect.pw5 = pw5
            effect.pw6 = pw6
            effect.pw7 = pw7
        }
    }

    // Music parameters
    property real pw0: 0
    property real pw1: 0
    property real pw2: 0
    property real pw3: 0
    property real pw4: 0
    property real pw5: 0
    property real pw6: 0
    property real pw7: 0

    property real loudness: 0

    property real time: timeManager.time

    anchors.fill: parent
    blending: false

    //Print the number with a reasonable precision for the shader.
    function str(num){
        return num.toFixed(8);
    }

    fragmentShader: "
        #define WAVES 2.0
        #ifdef GL_ES
            precision mediump float;
        #endif

        uniform highp float qt_Opacity;
        uniform highp float time;
        varying highp vec2 qt_TexCoord0;

        uniform highp vec4 fontColor;

        uniform mediump float loudness;
        uniform lowp float pw0;
        uniform lowp float pw1;
        uniform lowp float pw2;
        uniform lowp float pw3;
        uniform lowp float pw4;
        uniform lowp float pw5;
        uniform lowp float pw6;
        uniform lowp float pw7;" +

        "void main() {
            vec3 txt_color = vec3(0.0);

            vec2 uv = qt_TexCoord0;
            vec2 p = (uv * 2.0 - 1.0) * 15.0;
            vec2 sfunc = vec2(p.x, p.y);
            float baseFreq = 4.0;
            float baseAmp = 1.0 * loudness;
            float speed = 10.0;

            sfunc.y += baseAmp * (pw0) * sin(uv.x * baseFreq + speed * time);
            sfunc.y += baseAmp * (pw1) * sin(uv.x * 2.0 * baseFreq + (speed + 0.1) * time);
            sfunc.y += baseAmp * (pw2) * sin(uv.x * 4.0 * baseFreq + (speed + 0.2) * time);
            sfunc.y += baseAmp * (pw3) * sin(uv.x * 8.0 * baseFreq + (speed + 0.3) * time);
            sfunc.y += baseAmp * (pw4) * sin(uv.x * 16.0 * baseFreq + (speed + 0.4) * time);
            sfunc.y += baseAmp * (pw5) * sin(uv.x * 32.0 * baseFreq + (speed + 0.5) * time);

            sfunc.y *= uv.x * 2.0 + 0.05;
            sfunc.y *= 2.0 - uv.x * 2.0 + 0.05;
            sfunc.y /= 0.1;

            vec3 c = vec3(abs(sfunc.y));
            c = pow(c, vec3(-0.5));
            c *= fontColor.rgb;
            txt_color = clamp(vec3(0.0), vec3(0.5), c);

            gl_FragColor = vec4(txt_color, qt_Opacity);" +
        "}"

     onStatusChanged: {
         // Print warning messages
         if (log)
             console.log(log);
     }
}
