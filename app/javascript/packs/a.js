
import swal from 'sweetalert2';

function showSwal(){
  const iframe = document.querySelector('.bibi-frame').contentWindow.document
  const current = iframe.getElementById("bibi-nombre-percent").innerHTML

  if (current.includes("100")) {
    swal({
      title: 'Good job!',
      text: 'You fininsh the book, go and answer the quiz!',
      type: 'success',
    })
}
}
setInterval(showSwal, 5000);
