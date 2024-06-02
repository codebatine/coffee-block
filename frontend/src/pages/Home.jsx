import { Link } from 'react-router-dom';
import img1 from '../content/img/coffee-7.jpg';
import img2 from '../content/img/coffee-9.jpg';

export const Home = () => {
  return (
    <div className="main-content">
      <div className="content-container">
        <h1 className="josefin-sans">Coffee Block</h1>
        <p>Coffe Block lets crypto users support small coffee farms using any crypto of choice. For this we have set up smart contracts using Chainlink's CCIP.</p>
        <p>Go and see projects to support right away in the <Link to="/viewall" className="highlighted-link">Project page!</Link></p>

        <h2>Our Mission</h2>
        <img className="responsive-img" src={img2} alt="Coffee." />
        <p>The idea was born out of our passion for crypto and coffee! We wanted to create a project that allows crypto coffee lovers to support small scale farms and producers.</p>
        <img className="responsive-img" src={img1} alt="Coffee." />
        <p>We open up new avenues for financial inclusivity by enabling anyone with cryptocurrency to participate in supporting local coffee farmers, regardless of geographical barriers. This means immediate support, interactivity and community building as a result. With blockchain technology, Coffee Block ensures transparency and accountability throughout the donation process, allowing supporters to track their contributions and monitor their impact in real time.</p>
      </div>
    </div>
  );
};