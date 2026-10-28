const themeButton = document.querySelector('[data-theme-toggle]');

function updateThemeButton() {
  if (!themeButton) return;
  const isDark = document.documentElement.dataset.theme === 'dark';
  const label = isDark ? '切换到浅色模式' : '切换到深色模式';
  themeButton.setAttribute('aria-label', label);
  themeButton.title = label;
}

updateThemeButton();

themeButton?.addEventListener('click', () => {
  const nextTheme = document.documentElement.dataset.theme === 'dark' ? 'light' : 'dark';
  document.documentElement.dataset.theme = nextTheme;
  try {
    localStorage.setItem('suiji-theme', nextTheme);
  } catch {}
  updateThemeButton();
});

window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
  try {
    if (localStorage.getItem('suiji-theme')) return;
  } catch {}
  document.documentElement.dataset.theme = event.matches ? 'dark' : 'light';
  updateThemeButton();
});

const tocLinks = [...document.querySelectorAll('#TableOfContents a')];
const headings = tocLinks.map(link => document.getElementById(decodeURIComponent(link.hash.slice(1)))).filter(Boolean);

if ('IntersectionObserver' in window && headings.length) {
  const observer = new IntersectionObserver(entries => {
    for (const entry of entries) {
      if (!entry.isIntersecting) continue;
      for (const link of tocLinks) {
        link.classList.toggle('is-active', decodeURIComponent(link.hash.slice(1)) === entry.target.id);
      }
    }
  }, { rootMargin: '-10% 0px -65% 0px' });
  headings.forEach(heading => observer.observe(heading));
}
