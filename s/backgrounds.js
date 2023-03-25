var backgroundImages = ['https://cdn.wolfite.net/bg/m/1.png', 'https://cdn.wolfite.net/bg/m/2.png', 'https://cdn.wolfite.net/bg/m/3.png'];

document.addEventListener('DOMContentLoaded', function () {

  var randomIndex = Math.floor(Math.random() * backgroundImages.length);

  try {
    document.body.style.backgroundImage = 'url(' + backgroundImages[randomIndex] + ')';
  } catch (error) {
    console.error(error);
  }
});
