import {deleteJson, patchJson, postJson} from './ajax.js'

var observe;
if (window.attachEvent) {
  observe = function (element, event, handler) {
    element.attachEvent('on'+event, handler);
  };
}
else {
  observe = function (element, event, handler) {
    element.addEventListener(event, handler, false);
  };
}

function init (text) {
  function resize () {
    text.style.height = 'auto';
    text.style.height = text.scrollHeight+'px';
  }

  /* 0-timeout to get the already changed text */
  function delayedResize () {
    window.setTimeout(resize, 0);
  }
  observe(text, 'change',  resize);
  observe(text, 'cut',     delayedResize);
  observe(text, 'paste',   delayedResize);
  observe(text, 'drop',    delayedResize);
  observe(text, 'keydown', delayedResize);

  text.focus();
  text.select();
  resize();
}

document.addEventListener("turbolinks:load", (_event) => {
  if (document.querySelector(".js-RecipeEditor")) {

    document.querySelector('.js-RecipeView__ingredient-create-button').addEventListener('click', (event) => {
      event.preventDefault()

      let ingredientTextAreaElement = document.querySelector('.js-RecipeView__ingredient-create-form-content')
      let ingredientBody = {
        content: ingredientTextAreaElement.value,
        recipe_id: ingredientTextAreaElement.dataset.recipeId
      }

      postJson(
        `/recipes/${ingredientBody.recipe_id}/ingredients`, {
          ingredients: [ingredientBody]
        }, (response) => {
          window.location.reload();
        }
      )
    });

    document.querySelector('.js-RecipeView__add-ingredients').addEventListener('click', (event) => {
       let body = Array.from(document.querySelectorAll('.js-RecipeEditor__ingredient-checkbox:checked')).reduce((acc, ingredientCheckboxElement) => {
         if (acc.recipe_id === 0 ) {
           acc.recipe_id = ingredientCheckboxElement.dataset.recipeId
         }

         acc.ingredients.push({
           content: ingredientCheckboxElement.dataset.content,
           recipe_id: ingredientCheckboxElement.dataset.recipeId
         })

         acc.parsed_line_ids.push(ingredientCheckboxElement.value)

         return acc
       }, {ingredients: [], parsed_line_ids: [], recipe_id: 0})

      postJson(
        `/recipes/${body.recipe_id}/ingredients`, {
          ingredients: body.ingredients,
          parsed_line_ids: body.parsed_line_ids
        }, (response) => {
          window.location.reload();
        }
      )
    })

    document.querySelector('.js-RecipeView__tool-create-button').addEventListener('click', (event) => {
      event.preventDefault()

      let toolTextAreaElement = document.querySelector('.js-RecipeView__tool-create-form-content')
      let toolBody = {
        content: toolTextAreaElement.value,
        recipe_id: toolTextAreaElement.dataset.recipeId
      }

      postJson(
        `/recipes/${toolBody.recipe_id}/tools`, {
          tools: [toolBody]
        }, (response) => {
          window.location.reload();
        }
      )
    });

    document.querySelector('.js-RecipeView__add-tools').addEventListener('click', (event) => {
       let body = Array.from(document.querySelectorAll('.js-RecipeEditor__tool-checkbox:checked')).reduce((acc, toolCheckboxElement) => {
         if (acc.recipe_id === 0 ) {
           acc.recipe_id = toolCheckboxElement.dataset.recipeId
         }

         acc.tools.push({
           content: toolCheckboxElement.dataset.content,
           recipe_id: toolCheckboxElement.dataset.recipeId
         })

         acc.parsed_line_ids.push(toolCheckboxElement.value)

         return acc
       }, {tools: [], parsed_line_ids: [], recipe_id: 0})

      postJson(
        `/recipes/${body.recipe_id}/tools`, {
          tools: body.tools,
          parsed_line_ids: body.parsed_line_ids
        }, (response) => {
          window.location.reload();
        }
      )
    })

    document.querySelector('.js-RecipeView__step-create-button').addEventListener('click', (event) => {
      event.preventDefault();

      let stepFormElement = document.querySelector('.js-RecipeView__step-create-form')

      let stepBody = {
        step: {
          content: stepFormElement.querySelector('.js-RecipeView__step-create-content').value.trim(),
          title: stepFormElement.querySelector('.js-RecipeView__step-create-title').value.trim(),
          recipe_id: stepFormElement.dataset.recipeId
        }
      }

      postJson(
        `/recipes/${stepBody.step.recipe_id}/steps`, stepBody, (response) => {
          window.location.reload();
        }
      )
    });

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

      if (stepId) {
        patchJson(
          `/recipes/${body.step.recipe_id}/steps/${stepId}`, {
            step: {content: body.step.content.join(" "), recipe_id: body.step.recipe_id},
            parsed_line_ids: body.parsed_line_ids
          }, (response) => {
            window.location.reload();
          }
        )
      } else {
        postJson(
          `/recipes/${body.step.recipe_id}/steps`, {
            step: {content: body.step.content.join(" "), recipe_id: body.step.recipe_id},
            parsed_line_ids: body.parsed_line_ids
          }, (response) => {
            window.location.reload();
          }
        )
      }
    })


    document.querySelector('.js-RecipeView__tip-create-button').addEventListener('click', (event) => {
      event.preventDefault();

      let tipFormElement = document.querySelector('.js-RecipeView__tip-create-form')

      let tipBody = {
        tip: {
          content: tipFormElement.querySelector('.js-RecipeView__tip-create-form-content').value.trim(),
          recipe_id: tipFormElement.dataset.recipeId
        }
      }

      postJson(
        `/recipes/${tipBody.tip.recipe_id}/tips`, tipBody, (response) => {
          window.location.reload();
        }
      )
    });

    document.querySelector('.js-RecipeView__add-tip').addEventListener('click', (event) => {
      let body = Array.from(document.querySelectorAll('.js-RecipeEditor__tip-checkbox:checked')).reduce((acc, tipCheckboxElement) => {

        acc.tip.content.push(tipCheckboxElement.dataset.content)

        acc.parsed_line_ids.push(tipCheckboxElement.value)

        return acc
      }, {tip: {content: []}, parsed_line_ids: []})

      postJson(
        `/recipes/${event.currentTarget.dataset.recipeId}/tips`, {
          tip: {content: body.tip.content.join(" ")},
          parsed_line_ids: body.parsed_line_ids
        }, (response) => {
          window.location.reload();
        }
      )
    })

    let tabs = document.querySelectorAll('[data-tab-target]')
    let tabContents = document.querySelectorAll('[data-tab-content]')

    Array.from(document.querySelectorAll('textarea')).forEach((textElement) => {
      init(textElement);
    });


    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        const tabContent = document.querySelector(tab.dataset.tabTarget)

        tabContents.forEach(tabContent => {
          tabContent.classList.remove('RecipeView__active-tab-content')
        })

        tabs.forEach(tab => {
          tab.classList.remove('RecipeView__active-tab-label')
        })

        tab.classList.add('RecipeView__active-tab-label')
        tabContent.classList.add('RecipeView__active-tab-content')

        Array.from(document.querySelectorAll('textarea')).forEach((textElement) => {
          init(textElement);
        });
      })
    })



  }
})
