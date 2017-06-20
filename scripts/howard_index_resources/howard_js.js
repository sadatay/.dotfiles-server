function show(id) {
    document.getElementById(id).style.display = 'inline';
    document.getElementById("toggle_hide_" + id).style.display = 'inline';
    document.getElementById("toggle_show_" + id).style.display = 'none';
}
function hide(id) {
    document.getElementById(id).style.display = 'none';
    document.getElementById("toggle_hide_" + id).style.display = 'none';
    document.getElementById("toggle_show_" + id).style.display = 'inline';
}
