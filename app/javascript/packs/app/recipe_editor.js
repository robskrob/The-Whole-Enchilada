import {postJson} from './ajax.js'

document.addEventListener("turbolinks:load", (_event) => {
  if (document.querySelector(".js-RecipeEditor")) {
    document.querySelector('.js-RecipeView__add-ingredients').addEventListener('click', (event) => {

      postJson(
        '/recipes/4/ingredients', {
          ingredients: [{
            id: 1,
            recipe_id: 2,
            content: 'test stub'
          }, {
            id: 2,
            recipe_id: 2,
            content: 'another one'
          }]
        }, (response) => {
          console.log('response', response)
        }
      )
    })
  }
})
