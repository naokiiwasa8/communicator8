// app/javascript/controllers/light_gray_circles_animation_controller.js
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

    const circles = [];
    for (let i = 0; i < 100; i++) {
      circles.push(this.createCircle());
    }

    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      circles.forEach(circle => {
        ctx.beginPath();
        ctx.arc(circle.x, circle.y, circle.radius, 0, 2 * Math.PI, false);
        ctx.fillStyle = circle.color;
        ctx.fill();

        circle.x += circle.dx;
        circle.y += circle.dy;

        if (circle.x > canvas.width || circle.x < 0) {
          circle.dx = -circle.dx;
        }
        if (circle.y > canvas.height || circle.y < 0) {
          circle.dy = -circle.dy;
        }
      });

      requestAnimationFrame(draw);
    };

    draw();
  }

  createCircle() {
    const radius = Math.random() * 5 + 2;
    const x = Math.random() * (this.containerTarget.offsetWidth - radius * 2) + radius;
    const y = Math.random() * (this.containerTarget.offsetHeight - radius * 2) + radius;
    const dx = (Math.random() - 0.5) * 2;
    const dy = (Math.random() - 0.5) * 2;

    return {
      x: x,
      y: y,
      dx: dx,
      dy: dy,
      radius: radius,
      color: `rgba(211, 211, 211, ${Math.random() * 0.4 + 0.1})`
    };
  }
}
