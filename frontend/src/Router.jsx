import { createBrowserRouter } from "react-router-dom";
import { Layout } from "./pages/Layout";
import { NotFound } from "./pages/NotFound";
import { Home } from "./pages/Home";
import { Viewall } from "./pages/Viewall";
import { Details } from "./pages/Details";
import { Loan } from "./pages/Loan";
import { Apply } from "./pages/Apply";
import { About } from "./pages/About";
import { Admin } from "./pages/Admin";

export const router = createBrowserRouter([
  {
    path: "/coffeblock/",
    element: <Layout />,
    errorElement: <NotFound />,
    children: [
      { path: "/coffeblock/", index: true, element: <Home /> },
      { path: "/coffeblock/viewall", element: <Viewall /> },
      { path: "/coffeblock/details", element: <Details /> },
      { path: "/coffeblock/loan", element: <Loan /> },
      { path: "/coffeblock/apply", element: <Apply /> },
      { path: "/coffeblock/about", element: <About /> },
      { path: "/coffeblock/admin", element: <Admin /> },
    ],
  },
]);
