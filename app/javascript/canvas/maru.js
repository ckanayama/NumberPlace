window.addEventListener('load', function() {
  draw();
});

function draw(x) {
  var canvas = document.getElementById("maru");
  canvas.width = 120;
  canvas.height = 120;
  var ctx = canvas.getContext("2d");
  ctx.clearRect(0,0, canvas.width, canvas.height);

  ctx.beginPath();
  ctx.fillStyle = "#fff";
  ctx.arc(60, 100, 30, 0, 2 * Math.PI);
  ctx.fill();

  ctx.beginPath();
  ctx.fillStyle = "#111";
  ctx.arc(46, 91, 3, 0, 2 * Math.PI);
  ctx.fill();

  ctx.beginPath();
  ctx.fillStyle = "#111";
  ctx.arc(68, 91, 3, 0, 2 * Math.PI);
  ctx.fill();
}
