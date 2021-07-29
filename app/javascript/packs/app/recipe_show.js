import ImageRotator from './services/image_rotator'
import ImageShrinker from './services/image_shrinker'
import ImageGrower from './services/image_grower'

document.addEventListener("turbolinks:load", (_event) => {
  var docWidth = document.documentElement.offsetWidth;

  if (document.querySelector(".js-RecipeShow")) {
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
