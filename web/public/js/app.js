$(() => {
    let health = 50;
    let armor = 50;
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
    
    window.addEventListener('message', (e) => {
        const type = e.data.type;
        if (type === "sethealth") {
            hl = e.data.value;
            hl = ((health - 100) / 100)
            if (health != hl) {
                setCompValue('health', hl)
                health = hl
                console.log(hl);
            }
        }
    })
    $('#armor').fadeOut();
    $('#oxygen').fadeOut();
})