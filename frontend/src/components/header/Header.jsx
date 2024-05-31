import { useState } from 'react';
import { NavLink } from 'react-router-dom';
import logo from '../../content/img/coffee-block-logo.jpeg';

export const Header = () => {
  const [isOpen, setIsOpen] = useState(false);

  const toggleMenu = () => {
    setIsOpen(!isOpen);
  };

  const closeMenu = () => {
    setIsOpen(false);
  };

  return (
    <header className="header">
      <div className="header-content">
        <img src={logo} alt="Coffee Block Logo" className="logo" />
        <ul className={`nav-links ${isOpen ? 'open' : ''}`}>
          <li>
            <NavLink to="/coffeblock/" end className={({ isActive }) => (isActive ? 'active-link' : '')} onClick={closeMenu}>
              Home
            </NavLink>
          </li>
          
          <li>
            <NavLink to="/coffeblock/viewall" className={({ isActive }) => (isActive ? 'active-link' : '')} onClick={closeMenu}>
              Projects
            </NavLink>
          </li>
          <li>
            <NavLink to="/coffeblock/apply" className={({ isActive }) => (isActive ? 'active-link' : '')} onClick={closeMenu}>
              Apply
            </NavLink>
          </li>
          <li>
            <NavLink to="/coffeblock/about" className={({ isActive }) => (isActive ? 'active-link' : '')} onClick={closeMenu}>
              About
            </NavLink>
          </li>
          <li>
            <NavLink to="/coffeblock/admin" className={({ isActive }) => (isActive ? 'active-link' : '')} onClick={closeMenu}>
              Admin
            </NavLink>
          </li>
        </ul>
      </div>
      <button id="menu-icon" className={isOpen ? 'open' : ''} onClick={toggleMenu}>
        <span></span>
        <span></span>
        <span></span>
      </button>
    </header>
  );
};