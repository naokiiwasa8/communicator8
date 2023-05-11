// app/javascript/controllers/geometry_animation_controller.js
import { Controller } from "@hotwired/stimulus";

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
    const shapeCount = window.innerWidth <= 768 ? 20 : 35;
    for (let i = 0; i < shapeCount; i++) {
      shapes.push(this.createShape());
    }

    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      shapes.forEach(shape => {
        ctx.save();
        ctx.translate(shape.x, shape.y);
        ctx.rotate(shape.rotation);
        ctx.strokeStyle = shape.color;
        ctx.lineWidth = 2;
        ctx.beginPath();

        const sides = shape.sides;
        ctx.moveTo(shape.size * Math.cos(0), shape.size * Math.sin(0));
        for (let i = 1; i <= sides; i++) {
          ctx.lineTo(
            shape.size * Math.cos((i * 2 * Math.PI) / sides),
            shape.size * Math.sin((i * 2 * Math.PI) / sides)
          );
        }

        ctx.closePath();
        ctx.stroke();
        ctx.restore();

        shape.rotation += shape.rotationSpeed;
      });

      requestAnimationFrame(draw);
    };

    draw();
  }

  createShape() {
    const size = Math.random() * 40 + 20;
    const randomColor = () => Math.floor(Math.random() * 210 + 45);
    return {
      x: Math.random() * this.containerTarget.offsetWidth,
      y: Math.random() * this.containerTarget.offsetHeight,
      size: size,
      sides: Math.floor(Math.random() * 4) + 3,
      rotation: Math.random() * Math.PI * 2,
      rotationSpeed: (Math.random() - 0.5) * 0.01,
      color: `rgba(${randomColor()}, ${randomColor()}, ${randomColor()}, ${Math.random() * 0.2 + 0.1})`
    };
  }
}
