import { NavLink } from 'react-router-dom';
import { CoffeeCupLogo } from '../../pages/CoffeeCupLogo';

export const Header = () => {
  return (
    <header className="header">
      <CoffeeCupLogo />
      <ul className="nav-links">
        <li>
          <NavLink to="/coffeblock/" end className={({ isActive }) => (isActive ? 'active-link' : '')} >
            Home
          </NavLink>
        </li>
        <li>
          <NavLink to="/coffeblock/viewall" className={({ isActive }) => (isActive ? 'active-link' : '')}>
            View all
          </NavLink>
        </li>
        <li>
          <NavLink to="/coffeblock/apply" className={({ isActive }) => (isActive ? 'active-link' : '')}>
            Apply
          </NavLink>
        </li>
        <li>
          <NavLink to="/coffeblock/about" className={({ isActive }) => (isActive ? 'active-link' : '')}>
            About
          </NavLink>
        </li>
        <li>
          <NavLink to="/coffeblock/admin" className={({ isActive }) => (isActive ? 'active-link' : '')}>
            Admin
          </NavLink>
        </li>
      </ul>
    </header>
  );
};