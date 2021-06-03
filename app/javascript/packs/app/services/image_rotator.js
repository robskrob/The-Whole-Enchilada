export default class ImageRotator {
  constructor(imageElement, direction) {
    this.imageElement = imageElement
    this.direction = direction
  }

  calculate() {
    let rotateValue = this.imageElement.getAttribute('data-rotate')
    let scaleValue = this.imageElement.getAttribute('data-scale')

    if (rotateValue || scaleValue) {
      let transformObject = {rotate: rotateValue, scale: scaleValue}
      let transformArray = Object.keys(transformObject).reduce((acc, transformKey) => {

        if (transformKey === 'rotate' && transformObject[transformKey]) {
          let num = Number(transformObject[transformKey])
          let amount = this.tick(num)

          acc.push(`rotate(${amount}deg)`)
          this.imageElement.setAttribute('data-rotate', amount)
        } else if (transformKey === 'rotate' && !transformObject[transformKey]) {
          let amount = this.tick(0)
          acc.push(`rotate(${amount}deg)`)
          this.imageElement.setAttribute('data-rotate', amount)
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
      this.imageElement.setAttribute(`data-rotate`, this.tick(0))
      this.imageElement.style.transform = `rotate(${this.tick(0)}deg)`
    }
  }

  // PRIVATE

  tick(amount) {
    if (this.direction === 'left') {
      return amount - 90
    } else {
      return amount + 90
    }
  }

}

