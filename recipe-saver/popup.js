function hello() {
  console.log('hello!!');
}

document.addEventListener("DOMContentLoaded", function(event) {
  document.querySelector('#clickme').addEventListener('click', hello);
});
