import img1 from '../content/img/coffee-8.jpg';

export const About = () => {
  return (
    <div className="content-container">
        <h2 className="josefin-sans"> A Hackathon Project</h2>
        <p>Coffe Block lets crypto users support small coffee farms using any crypto of choice. For this we have set up smart contracts using Chainlink's CCIP.</p>
        <p><em>Coffee beans and crypto have a lot in common!</em></p>
        <a href="https://github.com/codebatine/coffee-block" target="_blank" rel="noopener noreferrer">
        <button className="application-button">GitHub Repo</button>
        </a>
        <p>We would like to improve this further and are open for suggestions and disucssions. Here's our <a href="https://t.me/+yHxclZ9JCyQ1ZjFk" target="_blank" rel="noopener noreferrer">Coffee Block Telegram group. ☕</a></p>
        <img className="responsive-img" src={img1} alt="Coffee." />
      </div>
  )
}