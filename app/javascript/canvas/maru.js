window.addEventListener('load', function() {
  const canvas = document.getElementById("maru");

  draw(canvas);

  const mouseMove = (event) => {
    canvas.style.top = (event.clientY - 30) + "px";
    canvas.style.left = (event.clientX - 30) + "px";
  }

  canvas.onmousedown = function() {
    canvas.addEventListener('mousemove', mouseMove);
  };

  canvas.onmouseup = function() {
    canvas.removeEventListener('mousemove', mouseMove);
  }
});

function draw(canvas) {
  canvas.width = 60;
  canvas.height = 60;
  let ctx = canvas.getContext("2d");
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  ctx.beginPath();
  ctx.fillStyle = "#fff";
  ctx.arc(30, 30, 30, 0, 2 * Math.PI);
  ctx.fill();

  ctx.beginPath();
  ctx.fillStyle = "#111";
  ctx.arc(15, 20, 3, 0, 2 * Math.PI);
  ctx.fill();

  ctx.beginPath();
  ctx.fillStyle = "#111";
  ctx.arc(33, 20, 3, 0, 2 * Math.PI);
  ctx.fill();
}
