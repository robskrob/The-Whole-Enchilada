import {patchJson, postJson} from './ajax.js'

document.addEventListener("turbolinks:load", (_event) => {
  if (document.querySelector(".js-RecipeEditor")) {
    document.querySelector('.js-RecipeView__add-ingredients').addEventListener('click', (event) => {
       let body = Array.from(document.querySelectorAll('.js-RecipeEditor__ingredient-checkbox:checked')).reduce((acc, ingredientCheckboxElement) => {
         acc.ingredients.push({
           content: ingredientCheckboxElement.dataset.content,
           recipe_id: ingredientCheckboxElement.dataset.recipeId
         })

         acc.parsed_line_ids.push(ingredientCheckboxElement.value)

         return acc
       }, {ingredients: [], parsed_line_ids: []})

      postJson(
        '/recipes/4/ingredients', {
          ingredients: body.ingredients,
          parsed_line_ids: body.parsed_line_ids
        }, (response) => {
          window.location.reload();
        }
      )
    })

    document.querySelector('.js-RecipeView__add-tools').addEventListener('click', (event) => {
       let body = Array.from(document.querySelectorAll('.js-RecipeEditor__tool-checkbox:checked')).reduce((acc, toolCheckboxElement) => {
         acc.tools.push({
           content: toolCheckboxElement.dataset.content,
           recipe_id: toolCheckboxElement.dataset.recipeId
         })

         acc.parsed_line_ids.push(toolCheckboxElement.value)

         return acc
       }, {tools: [], parsed_line_ids: []})

      postJson(
        '/recipes/4/tools', {
          tools: body.tools,
          parsed_line_ids: body.parsed_line_ids
        }, (response) => {
          window.location.reload();
        }
      )
    })

    document.querySelector('.js-RecipeView__add-step').addEventListener('click', (event) => {
       let body = Array.from(document.querySelectorAll('.js-RecipeEditor__step-checkbox:checked')).reduce((acc, stepCheckboxElement) => {
         if (acc.step.recipe_id === 0 ) {
           acc.step.recipe_id = stepCheckboxElement.dataset.recipeId
         }

         acc.step.content.push(stepCheckboxElement.dataset.content)

         acc.parsed_line_ids.push(stepCheckboxElement.value)

         return acc
       }, {step: {content: [], recipe_id: 0}, parsed_line_ids: []})

      let stepId = document.querySelector('#choose_step').selectedOptions[0].value

      patchJson(
        `/recipes/4/steps/${stepId}`, {
          step: {content: body.step.content.join(" "), recipe_id: body.step.recipe_id},
          parsed_line_ids: body.parsed_line_ids
        }, (response) => {
          window.location.reload();
        }
      )
    })
  }
})
