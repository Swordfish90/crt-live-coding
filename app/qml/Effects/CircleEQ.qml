import QtQuick 2.0

ShaderEffect {
    id: effect

    property color fontColor: appSettings.fontColor

    Connections {
        target: oscData

        readonly property real prev: 0.90
        readonly property real next: 1.0 - prev

        onNewData: {
            effect.loud = loud / 100
            effect.pw0 = eqm[0] * next + effect.pw0 * prev
            effect.pw1 = eqm[1] * next + effect.pw1 * prev
            effect.pw2 = eqm[2] * next + effect.pw2 * prev
            effect.pw3 = eqm[3] * next + effect.pw3 * prev
            effect.pw4 = eqm[4] * next + effect.pw4 * prev
            effect.pw5 = eqm[5] * next + effect.pw5 * prev
            effect.pw6 = eqm[6] * next + effect.pw6 * prev
            effect.pw7 = eqm[7] * next + effect.pw7 * prev
        }
    }

    property real loud: 0

    property size resolution: Qt.size(width, height)

    property real time: timeManager.time

    property real pw0: 0.0
    property real pw1: 0.0
    property real pw2: 0.0
    property real pw3: 0.0
    property real pw4: 0.0
    property real pw5: 0.0
    property real pw6: 0.0
    property real pw7: 0.0

    anchors.fill: parent
    blending: false


    fragmentShader: "
        #ifdef GL_ES
            precision mediump float;
        #endif

        #define pi 3.14159265
        #define NUM 7.

        #define PALETTE vec3(.0, 1.4, 2.)+1.5
        //#define COLORED
        #define MIRROR
        #define ROTATE
        #define ROT_OFST

        uniform highp float qt_Opacity;
        uniform highp float time;
        varying highp vec2 qt_TexCoord0;

        uniform highp vec4 fontColor;
        uniform mediump vec2 resolution;

        uniform mediump float loud;

        uniform lowp float pw0;
        uniform lowp float pw1;
        uniform lowp float pw2;
        uniform lowp float pw3;
        uniform lowp float pw4;
        uniform lowp float pw5;
        uniform lowp float pw6;
        uniform lowp float pw7;

        mat2 mm2(in float a){float c = cos(a), s = sin(a);return mat2(c,-s,s,c);}
        float tri(in float x){return abs(fract(x)-.5);}
        vec2 tri2(in vec2 p){return vec2(tri(p.x+tri(p.y*2.)),tri(p.y+tri(p.x*2.)));}
        mat2 m2 = mat2( 0.970,  0.242, -0.242,  0.970 );

        " +

        "void main() {
           float aspect = resolution.x/resolution.y;
           float w = 50./sqrt(resolution.x*aspect+resolution.y);

            vec2 p = qt_TexCoord0 * 2. - 1.;
            p.x *= aspect;
            p*= 1.05;
            vec2 bp = p;

            #ifdef ROTATE
            p *= mm2(time*.25);
            #endif

            float lp = length(p);
            float id = floor(lp*NUM+.5)/NUM;

            #ifdef ROT_OFST
            p *= mm2(id*11.);
            #endif

            #ifdef MIRROR
            p.y = abs(p.y);
            #endif

            //polar coords
            vec2 plr = vec2(lp, atan(p.y, p.x));

            //Draw concentric circles
            float rz = 1.-pow(abs(sin(plr.x*pi*NUM))*1.25/pow(w,0.25),2.5);

            //get the current arc length for a given id
            float enp = 0.0;
            enp += (plr.y - (1.0 - pw7) * pi) * (step(1.0 / NUM, id) - step(2.0 / NUM, id));
            enp += (plr.y - (1.0 - pw6) * pi) * (step(2.0 / NUM, id) - step(3.0 / NUM, id));
            enp += (plr.y - (1.0 - pw5) * pi) * (step(3.0 / NUM, id) - step(4.0 / NUM, id));
            enp += (plr.y - (1.0 - pw4) * pi) * (step(4.0 / NUM, id) - step(5.0 / NUM, id));
            enp += (plr.y - (1.0 - pw3) * pi) * (step(5.0 / NUM, id) - step(6.0 / NUM, id));
            enp += (plr.y - (1.0 - pw2) * pi) * (step(6.0 / NUM, id) - step(7.0 / NUM, id));
            enp += (plr.y - (1.0 - pw1) * pi) * (step(7.0 / NUM, id) - step(8.0 / NUM, id));
            enp += (plr.y - (1.0 - pw0) * pi) * (0.5 * step(8.0 / NUM, id) - step(9.0 / NUM, id));
            rz *= smoothstep(0., 0.05, enp);

            //smooth out both sides of the arcs (and clamp the number)
            rz *= smoothstep(0.,.022*w/plr.x, enp)*step(id,1.);
            #ifndef MIRROR
            rz *= smoothstep(-0.01,.02*w/plr.x,pi-plr.y);
            #endif

            vec3 col = (sin(PALETTE+id*5.+time)*0.5+0.5)*rz;
            col *= smoothstep(.8,1.15,rz)*.7+.8;

            #ifndef COLORED
            col = vec3(dot(col,vec3(.7)));
            #endif

            col = col * 0.5 * loud;

            gl_FragColor = vec4(col * fontColor.rgb, qt_Opacity);" +
        "}"

     onStatusChanged: {
         // Print warning messages
         if (log)
             console.log(log);
     }
}
