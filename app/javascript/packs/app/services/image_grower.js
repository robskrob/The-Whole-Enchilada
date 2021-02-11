export default class ImageShrinker {
  constructor(imageElement) {
    this.imageElement = imageElement
  }

  calculate() {
    let rotateValue = this.imageElement.getAttribute('data-rotate')
    let scaleValue = this.imageElement.getAttribute('data-scale')

    if (rotateValue || scaleValue) {
      let transformObject = {rotate: rotateValue, scale: scaleValue}
      let transformArray = Object.keys(transformObject).reduce((acc, transformKey) => {

        if (transformKey === 'scale' && transformObject[transformKey]) {
          let num = Number(transformObject[transformKey])
          let amount = num + .1

          acc.push(`scale(${amount})`)
          this.imageElement.setAttribute('data-scale', amount)
        } else if (transformKey === 'scale' && !transformObject[transformKey]) {
          acc.push(`scale(1.1)`)
          this.imageElement.setAttribute('data-scale', 1.1)
        } else if (transformObject[transformKey]) {

          if (transformKey === 'rotate') {
            acc.push(`${transformKey}(${transformObject[transformKey]}deg)`)
          } else if (transformKey === 'scale') {
            acc.push(`${transformKey}(${transformObject[transformKey]})`)
          }

          this.imageElement.setAttribute(`data-${transformKey}`, transformObject[transformKey])
        }

        return acc;

      }, [])

      this.imageElement.style.transform = transformArray.join(' ')
    } else {
      this.imageElement.setAttribute(`data-scale`, .1)
      this.imageElement.style.transform = `scale(1.1)`
    }
  }
}

