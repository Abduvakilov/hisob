setTimeout(function() {
  let alerts = document.getElementsByClassName('alert')
  for (let i = 0; i < alerts.length; i++) {
    alerts[i].classList.remove('alert-error','alert-danger','alert-success');
    alerts[i].classList.add('border','rounded-0');
  }
}, 4000);

window.dismiss = (e) => {
	e.currentTarget.parentElement.classList.add('hide')
}