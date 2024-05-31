import img1 from '../content/img/coffee-4-grid.jpg';
import img2 from '../content/img/coffee-4-grid.jpg';

export const Home = () => {
  return (
    <div className="main-content">
      <div className="content-container">
        <h1 className="josefin-sans">Welcome to Home</h1>
        <p className="dosis">This is some dummy text for the home page. More content will be added soon.</p>
        <div className="grid-container">
          <div className="grid-item">
            <div className="img-container">
              <img src={img1} alt="Dummy" />
            </div>
          </div>
          <div className="grid-item">
            <div className="img-container">
              <img src={img2} alt="Dummy" />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};