function setCompValue(comp, value){
    const rem = getComputedStyle(document.documentElement).fontSize;
    console.log(parseFloat(rem) * 2.5)
    const basis = parseFloat(rem) * 2.5
    const obj = document.querySelector(`#${comp} .progress`)
    if (value >= 100){value = 100}
    if (value >= 80) {
        // if ($(obj).hasClass('lessthaneighty')) $(obj).removeClass('lessthaneighty');
        $(obj).css({borderRadius: "8px"})
    } else {
        $(obj).css({borderRadius: '0 0 8px 8px'})
    }
    $(obj).animate({height: value/100*basis})
}

