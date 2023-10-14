/*==================== SHOW MENU ====================*/
const navMenu = document.getElementById('nav-menu'),
    navToggle = document.getElementById('nav-toggle'),
    navClose = document.getElementById('nav-close')

/*===== MENU SHOW =====*/
if(navToggle){
    navToggle.addEventListener('click', () =>{
        navMenu.classList.add('show-menu')
    })
}

/*===== ACTIVE LINK =====*/
const links = document.querySelectorAll('.nav__link')

function activeLink(){
    // 모든 active-link 클래스 제거
    links.forEach(n => n.classList.remove('active-link'))
    // 클릭된 요소에 active-link 클래스 추가
    this.classList.add('active-link')
}
links.forEach(n => n.addEventListener('click', activeLink))



window.addEventListener('DOMContentLoaded', (event) => {
    const target = document.querySelector('#community');

    let observer = new IntersectionObserver(function(entries, observer) {
        entries.forEach(entry => {
            if(entry.isIntersecting){
                entry.target.style.backgroundColor = '#ddd';
            } else{
                entry.target.style.backgroundColor = ''; // 원래 배경색으로 돌아감
            }
        });
    }, { rootMargin: '-50% 0px -50% 0px' }); // 중간 지점에서 색상이 변경되도록 설정

    observer.observe(target);
});



window.addEventListener('DOMContentLoaded', (event) => {
    const target = document.querySelector('#cmt');

    let observer = new IntersectionObserver(function(entries, observer) {
        entries.forEach(entry => {
            if(entry.isIntersecting){
                entry.target.style.backgroundColor = '#ddd';
            } else{
                entry.target.style.backgroundColor = ''; // 원래 배경색으로 돌아감
            }
        });
    }, { rootMargin: '-50% 0px -50% 0px' }); // 중간 지점에서 색상이 변경되도록 설정

    observer.observe(target);
});



window.addEventListener('DOMContentLoaded', (event) => {
    const target = document.querySelector('#miniHome');

    let observer = new IntersectionObserver(function(entries, observer) {
        entries.forEach(entry => {
            if(entry.isIntersecting){
                entry.target.style.backgroundColor = '#ddd';
            } else{
                entry.target.style.backgroundColor = ''; // 원래 배경색으로 돌아감
            }
        });
    }, { rootMargin: '-50% 0px -50% 0px' }); // 중간 지점에서 색상이 변경되도록 설정

    observer.observe(target);
});



window.addEventListener('DOMContentLoaded', (event) => {
    const target = document.querySelector('#miniHome2');

    let observer = new IntersectionObserver(function(entries, observer) {
        entries.forEach(entry => {
            if(entry.isIntersecting){
                entry.target.style.backgroundColor = '#ddd';
            } else{
                entry.target.style.backgroundColor = ''; // 원래 배경색으로 돌아감
            }
        });
    }, { rootMargin: '-50% 0px -50% 0px' }); // 중간 지점에서 색상이 변경되도록 설정

    observer.observe(target);
});







/*===== REMOVE MENU MOBILE =====*/
const navLink = document.querySelectorAll('.nav__link')

function linkAction(){
    const navMenu = document.getElementById('nav-menu')
    navMenu.classList.remove('show-menu')
}
navLink.forEach(n => n.addEventListener('click', linkAction))

/*==================== CHANGE BACKGROUND HEADER. 스크롤 할 때 어느순간 navbar 배경이 흰색으로 변경 ====================*/
function scrollHeader(){
    const header = document.getElementById('header')
    // When the scroll is greater than 100 viewport height, add the scroll-header class to the header tag
    if(this.scrollY >= 100){
        header.classList.add('scroll-header');
    } else {
        header.classList.remove('scroll-header')
    }
}
window.addEventListener('scroll', scrollHeader)


/*==================== SWIPER DISCOVER ====================*/

var swiper = new Swiper(".discover__container", {
    effect: "coverflow",
    grabCursor: true,
    centeredSlides: true,
    slidesPerView: "auto",
    loop: true,
    spaceBetween: 32,
    coverflowEffect: {
        rotate: 0
    }
});

/*==================== VIDEO ====================*/
const videoFile = document.getElementById('video-file'),
    videoButton = document.getElementById('video-button'),
    videoIcon = document.getElementById('video-icon')

function playPause(){
    if (videoFile.paused){
        // Play video
        videoFile.play()
        // We change the icon
        videoIcon.classList.add('ri-pause-line')
        videoIcon.classList.remove('ri-play-line')
    }
    else {
        // Pause video
        videoFile.pause();
        // We change the icon
        videoIcon.classList.remove('ri-pause-line')
        videoIcon.classList.add('ri-play-line')

    }
}

videoButton.addEventListener('click', playPause)

function finalVideo(){
    // Video ends, icon change
    videoIcon.classList.remove('ri-pause-line')
    videoIcon.classList.add('ri-play-line')
}
// ended, when the video ends
videoFile.addEventListener('ended', finalVideo)

/*==================== SHOW SCROLL UP ====================*/
function scrollUp(){
    const scrollUp = document.getElementById('scroll-up');
    // When the scroll is higher than 200 viewport height, add the show-scroll class to the a tag with the scroll-top class
    if(this.scrollY >= 200){
        scrollUp.classList.add('show-scroll');
    } else{
        scrollUp.classList.remove('show-scroll')
    }
}
window.addEventListener('scroll', scrollUp)

/*==================== SCROLL SECTIONS ACTIVE LINK ====================*/
const sections = document.querySelectorAll('section[id]')

function scrollActive(){
    const scrollY = window.pageYOffset

    sections.forEach(current =>{
        const sectionHeight = current.offsetHeight
        const sectionTop = current.offsetTop - 50;
        sectionId = current.getAttribute('id')

        if(scrollY > sectionTop && scrollY <= sectionTop + sectionHeight){
            document.querySelector('.nav__menu a[href*=' + sectionId + ']').classList.add('active-link')
        }else{
            document.querySelector('.nav__menu a[href*=' + sectionId + ']').classList.remove('active-link')
        }
    })
}
window.addEventListener('scroll', scrollActive)

/*==================== DARK LIGHT THEME ====================*/
const themeButton = document.getElementById('theme-button')
const darkTheme = 'dark-theme'
const iconTheme = 'ri-sun-line'

// Previously selected topic (if user selected)
const selectedTheme = localStorage.getItem('selected-theme')
const selectedIcon = localStorage.getItem('selected-icon')

// We obtain the current theme that the interface has by validating the dark-theme class
const getCurrentTheme = () => document.body.classList.contains(darkTheme) ? 'dark' : 'light'
const getCurrentIcon = () => themeButton.classList.contains(iconTheme) ? 'ri-moon-line' : 'ri-sun-line'

// We validate if the user previously chose a topic
if (selectedTheme) {
    // If the validation is fulfilled, we ask what the issue was to know if we activated or deactivated the dark
    document.body.classList[selectedTheme === 'dark' ? 'add' : 'remove'](darkTheme)
    themeButton.classList[selectedIcon === 'ri-moon-line' ? 'add' : 'remove'](iconTheme)
}

// Activate / deactivate the theme manually with the button
themeButton.addEventListener('click', () => {
    // Add or remove the dark / icon theme
    document.body.classList.toggle(darkTheme)
    themeButton.classList.toggle(iconTheme)
    // We save the theme and the current icon that the user chose
    localStorage.setItem('selected-theme', getCurrentTheme())
    localStorage.setItem('selected-icon', getCurrentIcon())
})

/*==================== SCROLL REVEAL ANIMATION ====================*/
const sr = ScrollReveal({
    distance: '60px',
    duration: 2500,
    // reset: true,
})


sr.reveal(`.home__data, .home__social-link, .home__info,
          .section__title,
         .discover__container,
         .experience__data, .experience__overlay,
         .place__card,
         .sponsor__content,
         .footer__data, .footer__rights`,{
    origin: 'top',
    // interval: 100,
})

sr.reveal(`.about__data,
         .video__description,
         .subscribe__description`,{
    origin: 'left',
    interval: 100,
})

sr.reveal(`.about__img-overlay, 
         .video__content,
         .subscribe__form`,{
    origin: 'right',
    interval: 100,
})