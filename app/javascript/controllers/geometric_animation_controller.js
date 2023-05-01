import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="geometric-animation"
export default class extends Controller {
  static targets = ["container"];

  connect() {
    this.animate();
  }

  animate() {
    const container = this.containerTarget;
    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");
    container.appendChild(canvas);
    canvas.width = container.offsetWidth;
    canvas.height = container.offsetHeight;
    canvas.style.position = 'absolute';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.zIndex = -1;

    const shapes = [];
    for (let i = 0; i < 50; i++) {
      shapes.push(this.createShape());
    }

    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      shapes.forEach(shape => {
        ctx.save();
        ctx.translate(shape.x, shape.y);
        ctx.rotate(shape.rotation);
        ctx.fillStyle = shape.color;
        ctx.fillRect(-shape.size / 2, -shape.size / 2, shape.size, shape.size);
        ctx.restore();

        shape.y -= shape.speed;
        shape.rotation += shape.rotationSpeed;

        // Shapeが画面上部に消えたら、画面下部に再配置
        if (shape.y < -shape.size) {
          shape.y = canvas.height + shape.size;
        }
      });

      requestAnimationFrame(draw);
    };

    draw();
  }

  createShape() {
    const size = Math.random() * 20 + 10;
    const randomColor = () => Math.floor(Math.random() * 210 + 45);
    return {
      x: Math.random() * this.containerTarget.offsetWidth,
      y: Math.random() * this.containerTarget.offsetHeight,
      size: size,
      speed: Math.random() * 2 + 1,
      rotation: Math.random() * Math.PI * 2,
      rotationSpeed: (Math.random() - 0.5) * 0.01,
      color: `rgba(${randomColor()}, ${randomColor()}, ${randomColor()}, ${Math.random() * 0.2 + 0.1})`
    };
  }
}
