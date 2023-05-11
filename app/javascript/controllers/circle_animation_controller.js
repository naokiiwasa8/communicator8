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
    for (let i = 0; i < 50; i++) {
      circles.push(this.createCircle());
    }

    const draw = () => {
      ctx.clearRect(0, 0, canvas.width, canvas.height);

      circles.forEach(circle => {
        ctx.beginPath();
        ctx.arc(circle.x, circle.y, circle.radius, 0, 2 * Math.PI, false);
        ctx.fillStyle = circle.color;
        ctx.fill();

        circle.radius += circle.growthRate;

        if (circle.radius > circle.maxRadius) {
          const index = circles.indexOf(circle);
          circles.splice(index, 1);
          circles.push(this.createCircle());
        }
      });

      requestAnimationFrame(draw);
    };

    draw();
  }

  createCircle() {
    const maxRadius = Math.random() * 20 + 10;
    const randomColor = () => Math.floor(Math.random() * 210 + 45);
    return {
      x: Math.random() * this.containerTarget.offsetWidth,
      y: Math.random() * this.containerTarget.offsetHeight,
      radius: 0,
      growthRate: Math.random() * 0.5 + 0.1,
      maxRadius: maxRadius,
      color: `rgba(${randomColor()}, ${randomColor()}, ${randomColor()}, ${Math.random() * 0.2 + 0.1})`
    };
  }
}
