/*
  Copyright (C) 2011 - 2014 by the authors of the ASPECT code.

  This file is part of ASPECT.

  ASPECT is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2, or (at your option)
  any later version.

  ASPECT is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with ASPECT; see the file doc/COPYING.  If not see
  <http://www.gnu.org/licenses/>.
*/


#include "boundary_layers.h"
#include <aspect/geometry_model/interface.h>

namespace aspect
{
  namespace CompositionalInitialConditions
  {
    template <int dim>
    double
    BoundaryLayers<dim>::
    initial_composition (const Point<dim> &position, const unsigned int n_comp) const
    {
      const double depth = this->get_geometry_model().depth(position);
      const double maximal_depth = this->get_geometry_model().maximal_depth();

      if (n_comp == 0)
        {
          if ((depth < upper_layer_thickness)
              || (depth > maximal_depth - lower_layer_thickness))
            return 0.0;
          else if ((depth > upper_layer_thickness)
              && (depth < lithosphere_thickness))
            return 1.0;
          else
            return 1-mantle_morb_content;
        }
      else if (n_comp == 1)
        {
          if ((depth < upper_layer_thickness)
              || (depth > maximal_depth - lower_layer_thickness))
            return 1.0;
          else if ((depth > upper_layer_thickness)
              && (depth < lithosphere_thickness))
            return 0.0;
          else
            return mantle_morb_content;
        }
      return 0.0;
    }

    template <int dim>
    void
    BoundaryLayers<dim>::declare_parameters (ParameterHandler &prm)
    {
      prm.enter_subsection("Compositional initial conditions");
      {
        prm.enter_subsection("Boundary layers");
        {
          prm.declare_entry ("Upper boundary layer thickness", "7000",
                             Patterns::Double (0),
                             "The thickness of the upper boundary layer.");
          prm.declare_entry ("Lower boundary layer thickness","150000",
                             Patterns::Double (0),
                             "The thickness of the lower boundary layer.");
          prm.declare_entry ("Lithosphere thickness","100000",
                             Patterns::Double (0),
                             "The thickness of the oceanic lithosphere.");
          prm.declare_entry ("Mantle morb content","0.18",
                             Patterns::Double (0),
                             "The MORB content of the general mantle.");
        }
        prm.leave_subsection();
      }
      prm.leave_subsection();
    }


    template <int dim>
    void
    BoundaryLayers<dim>::parse_parameters (ParameterHandler &prm)
    {
      prm.enter_subsection ("Compositional fields");
      const unsigned int n_compositional_fields = prm.get_integer ("Number of fields");
      prm.leave_subsection ();

      prm.enter_subsection("Compositional initial conditions");
      {
        prm.enter_subsection("Boundary layers");
        {
          lower_layer_thickness          = prm.get_double ("Lower boundary layer thickness");
          lithosphere_thickness          = prm.get_double ("Lithosphere thickness");
          mantle_morb_content            = prm.get_double ("Mantle morb content");
          upper_layer_thickness          = prm.get_double ("Upper boundary layer thickness");
        }

        prm.leave_subsection();
      }
      prm.leave_subsection();
    }

  }
}

// explicit instantiations
namespace aspect
{
  namespace CompositionalInitialConditions
  {
    ASPECT_REGISTER_COMPOSITIONAL_INITIAL_CONDITIONS(BoundaryLayers,
                                                     "Boundary layers",
                                                     "Composition is given as two boundary layers.")
  }
}
