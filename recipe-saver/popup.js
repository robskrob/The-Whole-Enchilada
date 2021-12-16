document.querySelector('#save-recipe--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', findOrCreateRecipe);

function changeBackgroundColor() {
  console.log('here 333')
  console.log(document.querySelector('body'))
}

function findOrCreateRecipe() {

  console.log('here 111')
  chrome.tabs.query({active: true, currentWindow: true}, (tabs) => {
    console.log('here 222')
    chrome.scripting.executeScript({
      target: {tabId: tabs[0].id},
      func: changeBackgroundColor
    })
  });

}


// document.addEventListener("DOMContentLoaded", function(event) {
//   document.querySelector('#save-recipe--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', findOrCreateRecipe);
// });
