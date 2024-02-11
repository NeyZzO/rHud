$(() => {

    let health = 0;
    var armor = 0;
    let hunger = 50;
    let thirst = -1;
    let oxygen = 100;

    function setCompValue(comp, value){
        const rem = getComputedStyle(document.documentElement).fontSize;
        const basis = parseFloat(rem) * 2.0;
        const obj = document.querySelector(`#${comp} .progress`);
        if (value >= 100){value = 100}
        if (value >= 80) {
            $(obj).css({borderRadius: "8px"});
        } else {
            $(obj).css({borderRadius: '0 0 8px 8px'});
        }
        $(obj).css({height: (value/100)*basis});
    }


    function useArmor(value){
        if (value > 0 && armor == 0) {
            $('#armor').fadeIn();
            armor = value
            setCompValue('armor', value);
        } else if (value <= 0 && armor != 0){
            $('#armor').fadeOut();
            armor = value
            setCompValue('armor', value);
        } else {
            setCompValue('armor', value);
            armor = value;
        }
    };
    
    function useOxygen(value) {
        if (value < 100 && oxygen == 100) {
            $('#oxygen').fadeIn();
            oxygen = value
            setCompValue('oxygen', value);
        } else if (value >= 100 && oxygen != 100){
            $('#oxygen').fadeOut();
            oxygen = value
            setCompValue('oxygen', value);
        } else {
            setCompValue('oxygen', value);
            oxygen = value
        } 
    }

    const talkColors = {
       1: "#0033e1",
       2: "#ffffff",
       3: "#e11f00"
    }

    function SetTalkingMode(talkmode) {
        const talkIcon = $('#talkIcon')
        talkIcon.css({color: talkColors[talkmode]})
    }

    window.addEventListener('message', (e) => {
        const type = e.data.type;
        const value = e.data.value;
        if (type === "sethealth") {
            if (health != value) {
                let val = value - 100;
                if (val <= 0) {
                    val = Math.abs(val/100);
                };
                health = val;
                setCompValue('health', health);
            }
        } else if (type === "setarmor") {
            if (value != armor) {
                useArmor(value);
            }
        } else if (type === "sethunger") {
            if (value != hunger) {
                setCompValue('hunger', value);
            }
            
        } else if (type === "setthirst") {
            if (value != thirst) {
                setCompValue('thirst', value);
            }
        } else if (type === "setoxygen") {
            useOxygen((value/40)*100);
        } else if (type === "voicerange"){
            SetTalkingMode(value)
        } else if (type === "talking") {
            console.log('Changing talking mode')
            if (value) {
                $('#talkIcon').css({opacity: "1"})
            } else {
                $('#talkIcon').css({opacity: ".6"})
            }
        } else if (type == "toggle") {
            if (value) {
                $(document.body).show()
            } else {
                $(document.body).hide()
            }
        }
    })


    $('#armor').fadeOut();
    $('#oxygen').fadeOut();

    // Développement Local
    /*const setHealthevent = new Event('message');
    setHealthevent.data = {value: 100, type: "sethealth"};
    
    window.dispatchEvent(setHealthevent)

    const setArmorEvent = new Event('message');
    setArmorEvent.data = {value: 100, type: "setarmor"};
    
    window.dispatchEvent(setArmorEvent)*/


    fetch(`https://${GetParentResourceName()}/hudLoaded`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            ready: true
        })
    }).then((resp) => resp.json()).catch(err => console.error(err)).then((data) => {
        SetTalkingMode(data.voiceState);
    });
})