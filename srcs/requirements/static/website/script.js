const observer = new IntersectionObserver(entries => {

  entries.forEach(entry => {

    if (entry.isIntersecting) {

      entry.target.classList.add(
        "animate__animated",
        "animate__fadeInUp"
      );

    }

  });


});


document.querySelectorAll(
  ".card, .bonus-card, .flow div"
)
  .forEach(el => observer.observe(el));