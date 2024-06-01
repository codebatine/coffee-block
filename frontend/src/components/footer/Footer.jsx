import telegramImg from '../../content/img/telegram.png';

export const Footer = () => {
  return (
    <footer className="footer">

      <div className="copyright">
        <p>© 2024 Coffee Block.</p>
      </div>
      <div className="social-links">
        <a
          href="https://t.me/+yHxclZ9JCyQ1ZjFk"
          target="_blank"
          rel="noreferrer"
        >
          <img
            src={telegramImg}
            alt="Telegram"
          />
        </a>
      </div>
    </footer>
  )
}