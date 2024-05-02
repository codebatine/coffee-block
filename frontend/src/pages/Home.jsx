import coffee1 from '../content/img/coffee-1.jpg';
import coffee2 from '../content/img/coffee-2.jpg';
import coffee3 from '../content/img/coffee-3.jpg';
import coffee4 from '../content/img/coffee-4.jpg';
import coffee5 from '../content/img/coffee-5.jpg';
import coffee6 from '../content/img/coffee-6.jpg';

export const Home = () => {
  return (
    <main className="main-content">
      <div className="grid-container">
        <div className="grid-item">
          <div className="img-container">
            <img src={coffee1} alt="Coffee 1" />
          </div>
          <div className="caption">
            <h2>Your Caption</h2>
          </div>
          <h2>Headline 1</h2>
          <p>Some text about coffee.</p>
        </div>
        <div className="grid-item">
          <div className="img-container">
            <img src={coffee2} alt="Coffee 2" />
          </div>
          <div className="caption">
            <h2>Your Caption</h2>
          </div>
          <h2>Headline 2</h2>
          <p>Some text about coffee.</p>
        </div>
        <div className="grid-item">
          <div className="img-container">
            <img src={coffee3} alt="Coffee 3" />
          </div>
          <div className="caption">
            <h2>Your Caption</h2>
          </div>
          <h2>Headline 3</h2>
          <p>Some text about coffee.</p>
        </div>
        <div className="grid-item">
          <div className="img-container">
            <img src={coffee4} alt="Coffee 4" />
          </div>
          <div className="caption">
            <h2>Your Caption</h2>
          </div>
          <h2>Headline 4</h2>
          <p>Some more text about coffee.</p>
        </div>
        <div className="grid-item">
          <div className="img-container">
            <img src={coffee5} alt="Coffee 5" />
          </div>
          <div className="caption">
            <h2>Your Caption</h2>
          </div>
          <h2>Headline 5</h2>
          <p>Even more text about coffee.</p>
        </div>
        <div className="grid-item">
          <div className="img-container">
            <img src={coffee6} alt="Coffee 6" />
          </div>
          <div className="caption">
            <h2>Your Caption</h2>
          </div>
          <h2>Headline 6</h2>
          <p>And yet some more text about coffee.</p>
        </div>
      </div>
    </main>
  );
};