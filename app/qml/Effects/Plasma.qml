import QtQuick 2.0

ShaderEffect {
    id: effect

    property color fontColor: appSettings.fontColor

    Connections {
        target: oscData
        onNewData: {
            effect.loud = loud / 100

            effect.eq0 = eqm[0] * 0.2 + effect.eq0 * 0.8
            effect.eq1 = eqm[1] * 0.2 + effect.eq1 * 0.8
            effect.eq2 = eqm[2] * 0.2 + effect.eq2 * 0.8
            effect.eq3 = eqm[3] * 0.2 + effect.eq3 * 0.8
            effect.eq4 = eqm[4] * 0.2 + effect.eq4 * 0.8
            effect.eq5 = eqm[5] * 0.2 + effect.eq5 * 0.8
            effect.eq6 = eqm[6] * 0.2 + effect.eq6 * 0.8
            effect.eq7 = eqm[7] * 0.2 + effect.eq7 * 0.8
        }
    }

    // Music parameters
    property real eq0: 0
    property real eq1: 0
    property real eq2: 0
    property real eq3: 0
    property real eq4: 0
    property real eq5: 0
    property real eq6: 0
    property real eq7: 0

    property real loud: 0
    property real flat: 0
    property real centroid: 0

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

        uniform mediump float loud;
        uniform mediump float flat;
        uniform mediump float centroid;

        uniform lowp float eq0;
        uniform lowp float eq1;
        uniform lowp float eq2;
        uniform lowp float eq3;
        uniform lowp float eq4;
        uniform lowp float eq5;
        uniform lowp float eq6;
        uniform lowp float eq7;" +

        "void main() {
            vec3 txt_color = vec3(0.0);

            vec2 uv = qt_TexCoord0;
            vec2 p = (uv * 2.0 - 1.0) * 15.0;
            vec2 sfunc = vec2(p.x, p.y);
            float baseFreq = 4.0;
            float baseAmp = 1.5 * loud;
            float speed = 10.0;

            sfunc.y += baseAmp * eq0 * sin(uv.x * baseFreq + speed * time);
            sfunc.y += baseAmp * eq1 * sin(uv.x * 2.0 * baseFreq + (speed + 0.1) * time);
            sfunc.y += baseAmp * eq2 * sin(uv.x * 4.0 * baseFreq + (speed + 0.2) * time);
            sfunc.y += baseAmp * eq3 * sin(uv.x * 8.0 * baseFreq + (speed + 0.3) * time);
            sfunc.y += baseAmp * eq4 * sin(uv.x * 16.0 * baseFreq + (speed + 0.4) * time);
            sfunc.y += baseAmp * eq5 * sin(uv.x * 32.0 * baseFreq + (speed + 0.5) * time);

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
