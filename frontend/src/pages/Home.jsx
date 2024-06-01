import img1 from '../content/img/coffee-block-logo.jpeg';
import img2 from '../content/img/coffee-4-grid.jpg';

export const Home = () => {
  return (
    <div className="main-content">
      <div className="content-container">
        <h1 className="josefin-sans">Coffee Block</h1>
        <p>Coffe Block lets crypto users support small coffee farms using any crypto of choice. For this we have set up smart contracts using Chainlink's CCIP.</p>
        <img className="logo-img" src={img1} alt="Dummy" />
        <p>This is some text after the first image.</p>
        <img className="responsive-img" src={img2} alt="Dummy" />
        <p>This is some text after the second image.</p>
      </div>
    </div>
  );
};