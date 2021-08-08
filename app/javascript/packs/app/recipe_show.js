import ImageRotator from './services/image_rotator'
import ImageShrinker from './services/image_shrinker'
import ImageGrower from './services/image_grower'
import consumer from '../../channels/consumer'

document.addEventListener('turbolinks:load', (_event) => {
  const showRecipePage = document.querySelector('.js-RecipeShow')

  if (showRecipePage) {
    let recipeId = document.querySelector('[data-recipe-id]').dataset.recipeId
    consumer.subscriptions.create({ channel: 'RecipesChannel', id: recipeId }, {
      connected () {
        let image = window.localStorage.getItem('savedImage')

        if (image) {
          console.log('retrievedObject: ', JSON.parse(image))
          this.appendImage(JSON.parse(image))
          window.localStorage.setItem('savedImage', JSON.stringify(data))
          window.localStorage.removeItem('savedImage')
        }
      },

      received (data) {
        console.log('data', data)
        let image = window.localStorage.getItem('savedImage')
        this.appendImage(data)
      },

      appendImage (data) {
        const html = this.createImage(data)
        const element = document.querySelector('[data-images-container]')
        element.insertAdjacentHTML('beforeend', html)
      },

      createImage (data) {
        return `
        <div class="RecipeView__image-container js-RecipeShow__image">
          <div class="actions flex">
            <button class="js-rotate-left-btn">
            Rotate Left
            </button>
            <button class="js-rotate-right-btn">
            Rotate right
            </button>
            <button class="js-shrink">
            Shrink
            </button>
            <button class="js-grow">
            Grow
            </button>
          </div>
          <img src=${data.url} alt=${data.alt_text}>
          <a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/recipes/${data.recipe_id}/images/${data.image_id}">Delete Image</a>
          <a rel="nofollow" data-method="patch" href="/recipes/${data.recipe_id}/images/${data.image_id}/featured">Make Featured</a>
        </div>
      `
      }
    })

    Array.from(document.querySelectorAll('.js-rotate-left-btn')).forEach((buttonElement) => {
      buttonElement.addEventListener('click', (event) => {
        let img = event.currentTarget.parentElement.nextElementSibling
        let rotator = new ImageRotator(img, 'left')
        rotator.calculate()
      })
    })

    Array.from(document.querySelectorAll('.js-rotate-right-btn')).forEach((buttonElement) => {
      buttonElement.addEventListener('click', (event) => {
        let img = event.currentTarget.parentElement.nextElementSibling
        let rotator = new ImageRotator(img, 'right')
        rotator.calculate()
      })
    })

    Array.from(document.querySelectorAll('.js-shrink')).forEach((buttonElement) => {
      buttonElement.addEventListener('click', (event) => {
        let img = event.currentTarget.parentElement.nextElementSibling

        let shrinker = new ImageShrinker(img)
        shrinker.calculate()
      })
    })

    Array.from(document.querySelectorAll('.js-grow')).forEach((buttonElement) => {
      buttonElement.addEventListener('click', (event) => {
        let img = event.currentTarget.parentElement.nextElementSibling

        let grower = new ImageGrower(img)
        grower.calculate()
      })
    })
  }

})
