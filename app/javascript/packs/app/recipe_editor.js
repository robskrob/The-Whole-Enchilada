import { postJson} from './ajax.js'

document.addEventListener('turbolinks:load', (_event) => {
  const editRecipePage = document.querySelector('.js-RecipeEditor')
  if (editRecipePage) {
    Array.from(document.querySelectorAll('[data-web-images] > img')).forEach((imageElement) => {
      imageElement.addEventListener('click', (event) => {
        event.currentTarget.classList.toggle('selected')
      })
    })

    document.querySelector('[data-save-web-image]').addEventListener('click', (event) => {
      event.preventDefault()
      const imageData = Array.from(document.querySelectorAll('.selected')).map((selectedImageElement) => {
        return {
          source: selectedImageElement.getAttribute('src'),
          alt: selectedImageElement.getAttribute('alt')
        }
      })

      if (imageData.length) {
        postJson(`/api/v1/recipes/${editRecipePage.dataset.recipeId}/images`, {imageDataArray: imageData}, (response) => {
          console.log('response', response)
        })
      }
    })

  }
})
