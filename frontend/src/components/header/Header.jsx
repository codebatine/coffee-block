import React from 'react'
import { NavLink } from 'react-router-dom'

export const Header = () => {
  return (
    <>
    ---Header---
        <ul>
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
    </>
  )
}
