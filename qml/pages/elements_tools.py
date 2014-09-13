# Copyright (C) 2014 Magnus Nord
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import elements
import copy
import json
import os

class ElementList():
    def __init__(self):
        self.sorted_atomic_number_symbol_list = None
        self.sorted_eds_lines_list = None
        self.elements_rawdata = elements.elements

        self.make_sorted_atomic_number_symbol_list()
        self.make_sorted_eds_line_list()
        self.make_sorted_eels_edge_list()

    def make_sorted_atomic_number_symbol_list(self):
        filepath = os.path.dirname(os.path.realpath(__file__)) + "/data/"
        f = open(filepath + "element_list.json","r")
        temp_element_dict = json.load(f)
        self.sorted_atomic_number_symbol_list = temp_element_dict['element_list']
        f.close()

    def make_sorted_eels_edge_list(self):
        filepath = os.path.dirname(os.path.realpath(__file__)) + "/data/"
        f = open(filepath + "eels_edge_list.json","r")
        temp_eels_dict = json.load(f)
        self.sorted_eels_edge_list = temp_eels_dict['eels_edge_list']
        f.close()

    def make_sorted_eds_line_list(self):
        filepath = os.path.dirname(os.path.realpath(__file__)) + "/data/"
        f = open(filepath + "eds_line_list.json","r")
        temp_eds_dict = json.load(f)
        self.sorted_eds_line_list = temp_eds_dict['eds_line_list']
        f.close()

    def get_element_name(self, element_symbol):
        name = self.elements_rawdata[element_symbol]['General_properties']['name']
        name = name[:1].upper() + name[1:].lower()
        return(name)

    def get_element_density(self, element_symbol):
        density = self.elements_rawdata[element_symbol]['Physical_properties']['density (g/cm^3)']
        density = round(density, 2)
        return(density)

    def get_element_atomic_weight(self, element_symbol):
        atomic_weight = self.elements_rawdata[element_symbol]['General_properties']['atomic_weight']
        atomic_weight = round(atomic_weight, 2)
        return(atomic_weight)

    def get_atomic_number_symbol_list(self, search=""):
        if search is "":
            return(self.sorted_atomic_number_symbol_list)
        else:
            resultlist = []
            for element in self.sorted_atomic_number_symbol_list:
                if element['symbol'] == search:
                    resultlist.append(element)
                elif element['symbol'][0] == search:
                    resultlist.append(element)
                elif search in element['name']:
                    resultlist.append(element)
            return(resultlist)

    def get_sorted_eds_line_list(self):
        return(self.sorted_eds_line_list)

    def get_sorted_eels_edge_list(self,min_energy=None, max_energy=None):
        return(self.sorted_eels_edge_list)

    def _get_unsorted_xray_line_list(self,element_symbol):
        try:
            xray_lines = self.elements_rawdata[element_symbol]['Atomic_properties']['Xray_lines']
            xray_line_list = []
            for xray_line_name, xray_data in xray_lines.items():
                xray_line_weight = xray_data['weight']
                xray_line_weight = round(xray_line_weight, 2)
                xray_line_energy = xray_data['energy (keV)']
                xray_line_energy = round(xray_line_energy,3)
                xray_line_list.append([xray_line_name,xray_line_weight,xray_line_energy])
            return(xray_line_list)
        except:
            return(None)

    def get_xray_line_list(self, element_symbol):
        xray_line_list = self._get_unsorted_xray_line_list(element_symbol)
        xray_line_list.sort(key=lambda xray_energy: xray_energy[2])
        sorted_xray_line_list = []
        for xray_line in xray_line_list:
            sorted_xray_line_list.append(
                {'name':xray_line[0],'weight':xray_line[1],'energy':xray_line[2]})
        return(sorted_xray_line_list)

    def _get_unsorted_eels_edge_list(self, element_symbol):
        try:
            eels_edges = self.elements_rawdata[element_symbol]['Atomic_properties']['Binding_energies']
            eels_edge_list = []
            for eels_edge_name, eels_data in eels_edges.items():
                eels_edge_factor = eels_data['factor']
                eels_edge_factor = round(eels_edge_factor, 2)
                eels_edge_energy = eels_data['onset_energy (eV)']
                eels_edge_relevance = eels_data['relevance']
                eels_edge_list.append([eels_edge_name,eels_edge_factor,eels_edge_energy,eels_edge_relevance])
            return(eels_edge_list)
        except:
            return(None)

    def get_eels_edge_list(self, element_symbol):
        eels_edge_list = self._get_unsorted_eels_edge_list(element_symbol)
        eels_edge_list.sort(key=lambda xray_energy: xray_energy[2])

        sorted_eels_edge_list = []
        for eels_edge in eels_edge_list:
            sorted_eels_edge_list.append(
                {'name':eels_edge[0],'factor':eels_edge[1],'energy':eels_edge[2],'relevance':eels_edge[3]})
        
        return(sorted_eels_edge_list)

element_list = ElementList()
