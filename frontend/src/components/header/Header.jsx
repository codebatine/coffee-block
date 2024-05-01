import { NavLink } from 'react-router-dom';
import { CoffeeCupLogo } from '../../pages/CoffeeCupLogo';

export const Header = () => {
  return (
    <header className="header">
      <CoffeeCupLogo />
      <ul className="nav-links">
        <li>
          <NavLink to={"/coffeblock/"} >
            Home
          </NavLink>
        </li>
        <li>
          <NavLink to={"/coffeblock/viewall"} >
            View all
          </NavLink>
        </li>
        <li>
          <NavLink to={"/coffeblock/apply"} >
            Apply
          </NavLink>
        </li>
        <li>
          <NavLink to={"/coffeblock/about"} >
            About
          </NavLink>
        </li>
        <li>
          <NavLink to={"/coffeblock/admin"} >
            Admin
          </NavLink>
        </li>
      </ul>
    </header>
  );
};