import { postJson} from './ajax.js'

document.addEventListener('turbolinks:load', (_event) => {
  const editRecipePage = document.querySelector('.js-RecipeEditor')
  if (editRecipePage) {
    Array.from(document.querySelectorAll('[data-web-images] > img')).forEach((imageElement) => {
      imageElement.addEventListener('click', (event) => {
        const image = event.currentTarget
        if (!image.classList.contains('saved')) {
          event.currentTarget.classList.toggle('selected')
        }
      })
    })

    document.querySelector('[data-save-web-image]').addEventListener('click', (event) => {
      event.preventDefault()
      const imageElements = Array.from(document.querySelectorAll('.selected'))
      const imageData = imageElements.map((selectedImageElement) => {
        return {
          source: selectedImageElement.getAttribute('src'),
          alt: selectedImageElement.getAttribute('alt')
        }
      })

      if (imageData.length) {
        const spinnerModal = document.querySelector('[data-spinner-modal]')
        spinnerModal.classList.remove('hidden')
        postJson(`/api/v1/recipes/${editRecipePage.dataset.recipeId}/images`, {imageDataArray: imageData}, (response) => {
          spinnerModal.classList.add('hidden')

          imageElements.forEach((imageElement) => {
            imageElement.classList.add('saved')
            imageElement.classList.remove('selected')
          })

          window.location.href = `/recipes/${editRecipePage.dataset.recipeId}`
        })
      }
    })
  }
})
