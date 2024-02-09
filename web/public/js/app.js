$(() => {
    let health = 50;
    let armor = 0;
    let hunger = 50;
    let thirst = 50;
    function setCompValue(comp, value){
        const rem = getComputedStyle(document.documentElement).fontSize;
        const basis = parseFloat(rem) * 2.2;
        const obj = document.querySelector(`#${comp} .progress`);
        if (value >= 100){value = 100}
        if (value >= 90) {
            $(obj).css({borderRadius: "8px"});
        } else {
            $(obj).css({borderRadius: '0 0 8px 8px'});
        }
        $(obj).animate({height: (value/100)*basis});
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
            armor = value
        }
    }
    
    window.addEventListener('message', (e) => {
        const type = e.data.type;
        const value = e.data.value
        if (type === "sethealth") {
            if (health != value) {
                setCompValue('health', (value/200)* 100)
                health = value
                console.log((value/200)* 100);
            }
        } else if (type === "setarmor") {
            useArmor((value/255)*100)
        }
    })
    $('#armor').fadeOut();
    $('#oxygen').fadeOut();

    // Développement Local
    const setHealthevent = new Event('message');
    setHealthevent.data = {value: 100, type: "sethealth"};
    
    window.dispatchEvent(setHealthevent)

    const setArmorEvent = new Event('message');
    setArmorEvent.data = {value: 100, type: "setarmor"};
    
    window.dispatchEvent(setArmorEvent)
})