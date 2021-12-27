document.querySelector('#save-recipe--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', findOrCreateRecipe);
document.querySelector('#get-images--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', queryImages);

function getImages() {
  var imageDataArray = Array.from(document.querySelectorAll("[style*='background-image'], img")).reduce(function(acc, imageElement) {
    var imageSource = imageElement.getAttribute('src');
    var backgroundImageMatch = imageElement.style.backgroundImage.match(/url\(["']?([^"']*)["']?\)/);

    if (!/(http(s?)):\/\//i.test(imageSource)) {
      imageSource = "https:" + imageSource;
    }

    if (imageSource && imageSource.length > 0) {
      acc.push({
        source: imageSource,
        alt: imageElement.getAttribute('alt')
      })
    } else if (backgroundImageMatch) {
      acc.push({
        source: backgroundImageMatch[1],
        alt: "background image"
      })
    }

    return acc;
  }, []);

  return imageDataArray;
}

function queryImages() {
  chrome.tabs.query({active: true, currentWindow: true}, (tabs) => {
    chrome.scripting.executeScript({
      target: {tabId: tabs[0].id, allFrames: true},
      func: getImages
    }, (injectionResults) => {
      console.log(injectionResults)

      var imagesSectionElement = document.querySelector('.WholeEnchiladaRecipes_images-section--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // make popup html wider
      document.querySelector('#the-whole-enchilada-recipe-saver--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU')
        .setAttribute('style', 'width: 300px;');

      // hide get images button
      let getImagesButtonElement = document
        .querySelector('.WholeEnchiladaRecipes__get-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // hide get images button
      getImagesButtonElement
        .classList
        .remove('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // hide get images button
      getImagesButtonElement
        .classList
        .add('WholeEnchiladaRecipes_hide--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // show image selection instructions
      document.querySelector('.WholeEnchiladaRecipes_images-hero--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp ')
        .classList
        .add('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // insert images for selection into popup html
      injectionResults[0].result.forEach(function(imageData) {
        var imageElementString = "<img src='" +
          imageData.source +
          "' alt='" + imageData.alt + "' class='image--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp'>";

        imagesSectionElement.insertAdjacentHTML('afterbegin', imageElementString);
      })

      Array.from(document.querySelectorAll('img.image--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp')).forEach(function(imageElement) {
        imageElement.addEventListener('click', function(event) {
          event.preventDefault();
          event.currentTarget.classList.toggle('selected--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
        });
      });

      let importImagesButtonElement = document
        .querySelector('.WholeEnchiladaRecipes__import-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // show import image button
      importImagesButtonElement.classList.add('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');


      importImagesButtonElement
        .addEventListener('click', async (event) => {
          event.preventDefault();
          var recipeId = event.currentTarget.dataset.recipeId;

          var imageDataArray = Array.from(document.querySelectorAll('.selected--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp')).map(function(selectedImageElement) {
            return {
              source: selectedImageElement.getAttribute('src'),
              alt: selectedImageElement.getAttribute('alt')
            };
          })

          if (imageDataArray.length) {

            const response = await fetch("https://c7cc156138f4.ngrok.io/api/v1/recipes/" + recipeId + "/images", {
              method: 'POST', // *GET, POST, PUT, DELETE, etc.
              mode: 'cors', // no-cors, *cors, same-origin
              cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
              // credentials: 'same-origin', // include, *same-origin, omit
              headers: {
                'Content-Type': 'application/json'
                // 'Content-Type': 'application/x-www-form-urlencoded',
              },
              // redirect: 'follow', // manual, *follow, error
              // referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
              body: JSON.stringify({imageDataArray: imageDataArray}) // body data type must match "Content-Type" header
            });

            const imageData = await response.json()
            console.log('RESPONSE FROM THE WHOLE ENCHILADA', imageData);
            alert('Images saved!')

          }
        })
    })
  })
}


function postRecipeTextCallback() {
  const body = document.querySelector('body')

  // return body.innerText

  return {
    content: body.innerText,
    host_origin: window.location.host,
    name: window.location.host + window.location.pathname,
    pathname: window.location.pathname
  }

}

function findOrCreateRecipe() {

  console.log('here 111')
  chrome.tabs.query({active: true, currentWindow: true}, (tabs) => {
    console.log('here 222')
    //    chrome.runtime.sendMessage({'localStorage' : localStorage});

    chrome.scripting.executeScript({
      target: {tabId: tabs[0].id, allFrames: true},
      func: postRecipeTextCallback
    }, async (injectionResults) => {

      console.log(injectionResults)
      const response = await fetch('https://c7cc156138f4.ngrok.io/api/v1/web_recipes', {
        method: 'POST', // *GET, POST, PUT, DELETE, etc.
        mode: 'cors', // no-cors, *cors, same-origin
        cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
        // credentials: 'same-origin', // include, *same-origin, omit
        headers: {
          'Content-Type': 'application/json'
          // 'Content-Type': 'application/x-www-form-urlencoded',
        },
        // redirect: 'follow', // manual, *follow, error
        // referrerPolicy: 'no-referrer', // no-referrer, *no-referrer-when-downgrade, origin, origin-when-cross-origin, same-origin, strict-origin, strict-origin-when-cross-origin, unsafe-url
        body: JSON.stringify(injectionResults[0].result) // body data type must match "Content-Type" header
      });

      const data = await response.json()
      console.log('RESPONSE', data)

      const getImagesButtonElement = document.querySelector('.WholeEnchiladaRecipes__get-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
      const importButtonElement = document.querySelector('.WholeEnchiladaRecipes__import-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
      const saveButtonElement = document.querySelector('.WholeEnchiladaRecipes__save-recipe-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      importButtonElement.setAttribute('data-recipe-id', data.recipe.id);

      saveButtonElement.classList.add('WholeEnchiladaRecipes_hide--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
      getImagesButtonElement.classList.add('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');



    })
  });

}


// document.addEventListener("DOMContentLoaded", function(event) {
//   document.querySelector('#save-recipe--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', findOrCreateRecipe);
// });
