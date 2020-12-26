#!BPY

#
# Drag[en]gine Blender Scripts
#
# Copyright (C) 2004, Plüss Roland ( roland@rptd.dnsalias.net )
# 
# This program is free software; you can redistribute it and/or 
# modify it under the terms of the GNU General Public License 
# as published by the Free Software Foundation; either 
# version 2 of the License, or (at your option) any later 
# version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# NOTE: For the GPL copy see http://www.gnu.org/licenses/gpl.html
#

"""
Name: 'Drag[en]gine Intermediate Model (.dim)...'
Blender: 241
Group: 'Export'
Tooltip: 'Export selected meshes to Drag[en]gine Intermediate Model File Format (.dim)'
"""

__author__ = 'Plüss Roland (roland@rptd.dnsalias.net)'
__url__ = ('Project Epsylon, http://rptd.dnsalias.net/epsylon/')
__version__ = '1.0'
__bpydoc__ = """This script exports a high resolution and a low
resolution mesh into the denormgen intermediate format. The low
resolution mesh requires uv-coordinates and a material with a
texure containing an image. The uv coordinates are required to
stay inside the texture boundaries (hence no repeating uv
coordinates). The texture image is required to correctly calculate
uv coordinates. The high resolution mesh requires sub-division
enabled even if the sub-division level is set to 0.
"""

import Blender
from Blender.Mathutils import *
import struct, os, cStringIO, time, re
import math
from math import *



# constants
PI = 3.14159265
HALF_PI	= PI / 2.0
ONE_PI = PI / 180.0

# transformation matrices
tuv = 0.1 # scaling factor
transformPosition = Matrix( [-1,0,0,0], [0,0,-1,0], [0,1,0,0], [0,0,0,0] )
scalePosition = Matrix( [tuv,0,0,0], [0,tuv,0,0], [0,0,tuv,0], [0,0,0,1] )
transformScalePosition = transformPosition * scalePosition
terrainTransformPosition = Matrix( [1,0,0,0], [0,0,1,0], [0,1,0,0], [0,0,0,0] )
terrainTransformRotation = Matrix( [1,0,0,0], [0,0,-1,0], [0,1,0,0], [0,0,0,0] )




# global classes
# ( from Drag[en]gine http://epsylon.rptd.dnsalias.net/dragengine.php )
#########################################################################
class DEBone:
	def __init__( self, index, bone ):
		self.index = index
		self.bone = bone
		self.name = bone.name
		self.parent = None
		self.pos = Vector( [ 0, 0, 0 ] )
		self.rot = Vector( [ 0, 0, 0 ] )
		self.restMat = Matrix( [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] )
	def __repr__(self):
		return '[' + str( self.index ) + ' ' + str( self.name ) + ']'
	def __str__(self):
		return self.__repr__()

class DEWeight:
	def __init__( self, bone, weight ):
		self.bone = bone
		self.weight = weight
	def __repr__(self):
		return '[' + str( self.bone ) + '=' + str( self.weight ) + ']'
	def __str__(self):
		return self.__repr__()

class DEVertex:
	def __init__( self, index, vertex ):
		self.vertex = vertex
		self.edges = []
		self.faces = []
		self.index = index
		self.weights = []
	def __repr__(self):
		return '[' + str(self.index) + ': edges(' + str(self.edges) + '), faces(' + str(self.faces) + ') ]'
	def __str__(self):
		return self.__repr__()
	def findEdge(self, edges, v2):
		for edge in self.edges:
			if edges[edge].vertices[1] == v2:
				return edge
		return -1
	def getHardEdgeCount(self, edges):
		count = 0
		for edge in self.edges:
			if edges[edge].hard:
				count = count + 1
		return count

class DEEdge:
	def __init__(self, v1, v2, index):
		self.vertices = [ v1, v2 ]
		self.faces = [ -1, -1 ]
		self.index = index
		self.hard = False
	def __repr__(self):
		return '[' + str(self.index) + ': vertices(' + str(self.vertices[0]) + ', ' + str(self.vertices[1]) + '), hard=' + str(self.hard) + ', faces(' + str(self.faces) + ') ]'
	def __str__(self):
		return self.__repr__()

class DEFace:
	def __init__(self, verts, index):
		self.vertices = [ verts[0].index, verts[1].index, verts[2].index ]
		self.normals = [ -1, -1, -1 ]
		self.tangents = [ -1, -1, -1 ]
		self.edges = [ -1, -1, -1 ]
		self.index = index
		if len( verts ) == 4:
			self.vertices.append( verts[3].index )
			self.normals.append( -1 )
			self.tangents.append( -1 )
			self.edges.append( -1 )
	def __repr__(self):
		return '[' + str(self.index) + ': vertices(' + str(self.vertices) + '), normals(' + str(self.normals) + '), tangents(' + str(self.tangents) + ', edges(' + str(self.edges) + ') ]'
	def __str__(self):
		return self.__repr__()
	def findCorner(self, vertex):
		for index in range( len(self.vertices) ):
			if self.vertices[index] == vertex:
				return index
		return -1
	def setNormalFor(self, vertex, normal):
		for index in range( len(self.vertices) ):
			if self.vertices[index] == vertex:
				self.normals[index] = normal
	def setTangentFor( self, vertex, tangent ):
		for index in range( len( self.tangents ) ):
			if self.vertices[ index ] == vertex:
				self.tangents[ index ] = tangent

class DEKeyframe:
	def __init__(self, time, pos, rot):
		self.time = time
		self.pos = pos
		self.rot = rot

class DEMoveBone:
	def __init__(self, bone):
		self.bone = bone
		self.times = []
		self.keyframes = []

class DEMove:
	def __init__(self, action):
		self.action = action
		self.name = action.getName()

class DEChunk:
	def __init__(self, type):
		self.type
		self.content = ''
	def write(self, newContent):
		self.content = self.content + newContent
	def clear():
		self.content = ''
	def writeToFile(self, file):
		file.write( self.type[3] + self.type[2] + self.type[1] + self.type[0] )
		file.write( struct.pack( 'l', len( self.content ) ) )



# tangent calculator class. these classes are responsible
# to calculate tangent indices for the model. the base class
# simply calculates all tangents using the shared approach.
# hence the tangent index is the same as the normal index.
# subclass to implement your own behaviour.
class DIMTCCopyNormal:
	# constructor
	def __init__( self ):
		self.model = None
	# calculate tangents for the assigned model
	def calculateTangents( self ):
		self.model.tangentCount = self.model.normalCount
		for face in self.model.faces:
			face.tangents = face.normals
		return True



# the uv splitter class calculates tangents based on edge
# creasing and uv-edges. an edge is considered to be an
# uv-edge if the vertices of both connected faces have the
# same texture and are identical in uv coordinates.
class DIMTCUVSplitter( DIMTCCopyNormal ):
	# constructor
	def __init__( self ):
		DIMTCCopyNormal.__init__( self )
	# determine uv edges
	def determineUVEdges( self ):
		for edge in self.model.edges:
			# if there is only one face this has to be an uv-edge
			if edge.faces[ 0 ] == -1 or edge.faces[ 1 ] == -1:
				edge.uvEdge = True
			else:
				# get the faces involved
				face1 = self.model.mesh.faces[ edge.faces[ 0 ] ]
				face2 = self.model.mesh.faces[ edge.faces[ 1 ] ]
				# if the textures are different this is an uv-edge
				if( face1.materialIndex != face2.materialIndex ):
					edge.uvEdge = True
				else:
					deFace1 = self.model.faces[ edge.faces[ 0 ] ]
					deFace2 = self.model.faces[ edge.faces[ 1 ] ]
					# determine the uv coordinates of the first face
					f1v1 = None
					f1v2 = None
					for index2 in range( len( deFace1.vertices ) ):
						vert = deFace1.vertices[ index2 ]
						if vert == edge.vertices[ 0 ] or vert == edge.vertices[ 1 ]:
							if f1v1:
								f1v2 = face1.uv[ index2 ]
							else:
								f1v1 = face1.uv[ index2 ]
					if not f1v1 or not f1v2:
						alertUser( 'This should never happen! initCalcCornerTangents run into troubles!', 'Error')
						return False
					# determine the uv coordinates of the first face
					f2v1 = None
					f2v2 = None
					for index2 in range( len( deFace2.vertices ) ):
						vert = deFace2.vertices[ index2 ]
						if vert == edge.vertices[ 0 ] or vert == edge.vertices[ 1 ]:
							if f2v1:
								f2v2 = face2.uv[ index2 ]
							else:
								f2v1 = face2.uv[ index2 ]
					if not f2v1 or not f2v2:
						alertUser( 'This should never happen! initCalcCornerTangents run into troubles!', 'Error')
						return False
					# check if one of the possible combinations of uv-coordinates
					# leads to a match. if so this is not an uv-edge.
					if texelEquals( f1v1, f2v1 ):
						edge.uvEdge = not texelEquals( f1v2, f2v2 )
					elif texelEquals( f1v1, f2v2 ):
						edge.uvEdge = not texelEquals( f1v2, f2v1 )
					else:
						edge.uvEdge = True
		return True
	# retrieves the hard edge count for the normal but including uv edges
	def getVertexHardEdgeCount( self, vertex, edges ):
		count = 0
		for edge in vertex.edges:
			if edges[ edge ].uvEdge:
				count = count + 1
		return count
	# determines the tangents depending on normal creasing and uv edges
	def determineTangents( self ):
		self.model.tangentCount = 0
		for vert in self.model.vertices:
			hardEdgeCount = self.getVertexHardEdgeCount( vert, self.model.edges )
			if hardEdgeCount == 0:
				for face in vert.faces:
					self.model.faces[ face ].setTangentFor( vert.index, self.model.tangentCount )
				self.model.tangentCount = self.model.tangentCount + 1
			else:
				changed = True
				while changed:
					changed = False
					for index in vert.faces:
						face = self.model.faces[ index ]
						c = face.findCorner( vert.index )
						if face.tangents[ c ] == -1:
							edge = self.model.edges[ face.edges[ c ] ]
							if edge.faces[ 0 ] == face.index:
								neighbor = edge.faces[ 1 ]
							else:
								neighbor = edge.faces[ 0 ]
							if edge.uvEdge or neighbor == -1:
								face.tangents[ c ] = self.model.tangentCount
								self.model.tangentCount = self.model.tangentCount + 1
								changed = True
								break
							else:
								neighborFace = self.model.faces[ neighbor ]
								neighborCorner = neighborFace.findCorner( vert.index ) 
								if neighborFace.tangents[ neighborCorner ] != -1:
									face.tangents[ c ] = neighborFace.tangents[ neighborCorner ]
									changed = True
									break
		# in case of a 'improper' mesh add 'loose' tangents to fix things up.
		# improper means that there exist faces which have not a neighbor face
		# along an edge in the mesh but one in the texture. this case is useless
		# as the normals play dull there anyways. this fix simply prevents a
		# rejection to load in the application later on. the user is notified if
		# such a problem exists.
		improperMesh = False
		for face in self.model.faces:
			for index in range( len( face.tangents ) ):
				if face.tangents[ index ] == -1:
					face.tangents[ index ] = self.model.tangentCount
					self.model.tangentCount = self.model.tangentCount + 1
					improperMesh = True
		if improperMesh:
			Blender.Draw.PupMenu( 'Improper Mesh%t|Mesh contains faces not|touching in the mesh|but in the texture' )
		"""		for index in vert.faces:
					face = self.model.faces[ index ]
					c = face.findCorner( vert.index )
					if face.tangents[ c ] == -1:
						print 'Vertex Failed!'
						print vert
						for edge in vert.edges:
							print self.model.edges[ edge ], self.model.edges[ edge ].uvEdge
						for face in vert.faces:
							print self.model.faces[ face ]
						break
		# debug"""
		"""for face in self.model.faces:
			if face.tangents[ 0 ] == -1:
				print 'OH MY FSCKING GOD!', face
			if face.tangents[ 1 ] == -1:
				print 'OH MY FSCKING GOD!', face
			if face.tangents[ 2 ] == -1:
				print 'OH MY FSCKING GOD!', face
			if len( face.tangents ) == 4 and face.tangents[ 3 ] == -1:
				print 'OH MY FSCKING GOD!', face
		#	print 'Face', face.index, face.normals, face.tangents"""
		return True
	# calculate tangents for the assigned model
	def calculateTangents( self ):
		return self.determineUVEdges() and self.determineTangents()



# model class as we need two right now. this class should
# be extended to add different normal or tangent calculation
# variations. the basic version calculations normals depending
# on creasing values and tangents depending on uv-coordinates.
class DIMModel:
	# constructor
	def __init__( self ):
		self.objMesh = None
		self.mesh = None
		self.bones = []
		self.vertices = []
		self.edges = []
		self.faces = []
		self.triCount = 0
		self.quadCount = 0
		self.edgeCount = 0
		self.normalCount = 0
		self.multiFoldMesh = False
		self.degeneratedFaceCount = 0
	# process face corner
	def initProcessFaceCorner( self, vi, vo, c1, c2, fi ):
		vo[ c1 ].faces.append( fi )
		edge = vo[ c1 ].findEdge( self.edges, vi[ c2 ] )
		if edge == -1:
			edge = vo[ c2 ].findEdge( self.edges, vi[ c1 ] )
		theEdge = self.edges[ edge ]
		if theEdge.faces[ 0 ] == -1:
			theEdge.faces[ 0 ] = fi
		elif theEdge.faces[ 1 ] == -1:
			theEdge.faces[ 1 ] = fi
		else:
			self.multiFoldMesh = True
		self.faces[ fi ].edges[ c1 ] = edge
	# add vertices
	def initAddVertices( self ):
		if self.mesh:
			# add vertices
			for vert in self.mesh.verts:
				self.vertices.append( DEVertex( vert.index, vert ) )
			# add weights
			groups = self.mesh.getVertGroupNames()
			for group in groups:
				for bone in self.bones:
					if group == bone.name:
						weights = self.mesh.getVertsFromGroup( group, 1 )
						for weight in weights:
							if weight[ 1 ] > 0.001:
								self.vertices[ weight[ 0 ] ].weights.append( DEWeight( bone, weight[ 1 ] ) )
						break
	# add edges
	def initAddEdges( self ):
		if self.mesh:
			if not self.mesh.edges:
				self.mesh.addEdgesData()
			for index in range( len( self.mesh.edges ) ):
				edge = self.mesh.edges[ index ]
				newEdge = DEEdge( edge.v1.index, edge.v2.index, index )
				newEdge.crease = edge.crease / 255
				if edge.crease > 128:
					newEdge.hard = True
				self.edges.append( newEdge )
				self.vertices[ edge.v1.index ].edges.append( index )
				self.vertices[ edge.v2.index ].edges.append( index )
	# add faces
	def initAddFaces( self ):
		if self.mesh:
			for index in range( len( self.mesh.faces ) ):
				face = self.mesh.faces[ index ]
				newFace = DEFace( face.v, index )
				self.faces.append( newFace )
				# gather vertices and indices
				vi = [ face.v[ 0 ].index, face.v[ 1 ].index, face.v[ 2 ].index ]
				vo = [ self.vertices[ vi[ 0 ] ], self.vertices[ vi[ 1 ] ], self.vertices[ vi[ 2 ] ] ]
				if len( face.v ) == 4:
					vi.append( face.v[ 3 ].index )
					vo.append( self.vertices[ vi[ 3 ] ] )
				# corners
				count = len( face.v )
				for c in range( count ):
					self.initProcessFaceCorner( vi, vo, c, (c + 1) % count, index )
	# calculate corner normals
	def initCalcCornerNormals( self ):
		self.normalCount = 0
		for vert in self.vertices:
			hardEdgeCount = vert.getHardEdgeCount( self.edges )
			if hardEdgeCount == 0:
				for face in vert.faces:
					self.faces[ face ].setNormalFor( vert.index, self.normalCount )
				self.normalCount = self.normalCount + 1
			else:
				changed = True
				while changed:
					changed = False
					for index in vert.faces:
						face = self.faces[ index ]
						c = face.findCorner( vert.index )
						if face.normals[ c ] == -1:
							edge = self.edges[ face.edges[ c ] ]
							if edge.faces[ 0 ] == face.index:
								neighbor = edge.faces[ 1 ]
							else:
								neighbor = edge.faces[ 0 ]
							if edge.hard or neighbor == -1:
								face.normals[ c ] = self.normalCount
								self.normalCount = self.normalCount + 1
								changed = True
							else:
								neighborFace = self.faces[ neighbor ]
								neighborCorner = neighborFace.findCorner( vert.index ) 
								if neighborFace.normals[ neighborCorner ] != -1:
									face.normals[ c ] = neighborFace.normals[ neighborCorner ]
									changed = True
	# calculate corner tangents
	"""def initCalcCornerTangents( self ):
		# this trick doesn't seem to solve the problem. hence we use again
		# one tangent per normal
		self.tangentCount = self.normalCount
		for index in range( len( self.mesh.faces ) ):
			face = self.faces[ index ]
			for index2 in range( len( face.normals ) ):
				face.tangents[ index2 ] = face.normals[ index2 ]
		return True
		
		# do the same edge calculation like with the normals but use the uvEdge instead
		self.tangentCount = 0
		for vert in self.vertices:
			uvEdgeCount = vert.getUVEdgeCount( self.edges )
			if uvEdgeCount == 0:
				for face in vert.faces:
					self.faces[ face ].setTangentFor( vert.index, self.tangentCount )
				self.tangentCount = self.tangentCount + 1
			else:
				changed = True
				while changed:
					changed = False
					for index in vert.faces:
						face = self.faces[ index ]
						c = face.findCorner( vert.index )
						if face.tangents[ c ] == -1:
							edge = self.edges[ face.edges[ c ] ]
							if edge.faces[ 0 ] == face.index:
								neighbor = edge.faces[ 1 ]
							else:
								neighbor = edge.faces[ 0 ]
							if edge.uvEdge or neighbor == -1:
								face.tangents[ c ] = self.tangentCount
								self.tangentCount = self.tangentCount + 1
								changed = True
							else:
								neighborFace = self.faces[ neighbor ]
								neighborCorner = neighborFace.findCorner( vert.index ) 
								if neighborFace.tangents[ neighborCorner ] != -1:
									face.tangents[ c ] = neighborFace.tangents[ neighborCorner ]
									changed = True"""
	# calculate informational numbers
	def initCalcInfoNumbers( self ):
		if self.mesh:
			for face in self.mesh.faces:
				if len( face.v ) == 3:
					self.triCount = self.triCount + 1
				elif len( face.v ) == 4:
					self.quadCount = self.quadCount + 1
				else:
					self.degeneratedFaceCount = self.degeneratedFaceCount + 1
			if self.mesh.edges:
				self.edgeCount = len( self.mesh.edges )



# base exporter class
# ( modified from Drag[en]gine http://epsylon.rptd.dnsalias.net/dragengine.php )
##################################################################################
class DEBaseExporter:
	
	# constructor
	def __init__( self, tangentCalculator ):
		self.lowMesh = DIMModel()
		self.hiMesh = DIMModel()
		self.tangCalc = tangentCalculator
		self.tangCalc.model = self.lowMesh
		self.file = None
	
	# find mesh, armature and ref action
	def initFindMesh( self ):
		objects = Blender.Object.GetSelected()
		# try to find a messh
		for obj in objects:
			if obj.getType() == 'Mesh':
				mesh = obj.getData()
				if obj.getName()[-3:] == '.hi':
					if not self.hiMesh.objMesh:
						self.hiMesh.objMesh = obj
						self.hiMesh.mesh = mesh
				elif obj.getName()[-4:] == '.low':
					if not self.lowMesh.objMesh:
						self.lowMesh.objMesh = obj
						self.lowMesh.mesh = mesh
				else:
					alertUser( 'Mesh does not identify as low (.low) or high (.hi) resolution mesh', 'Error' )
					return False
	
	# find objects to export
	def initExporterObjects(self):
		self.initFindMesh()
		# high resolution mesh
		self.hiMesh.initAddVertices()
		self.hiMesh.initAddEdges()
		self.hiMesh.initAddFaces()
		self.hiMesh.initCalcCornerNormals()
		self.hiMesh.initCalcInfoNumbers()
		# low resolution mesh
		self.lowMesh.initAddVertices()
		self.lowMesh.initAddEdges()
		self.lowMesh.initAddFaces()
		self.lowMesh.initCalcCornerNormals()
		self.tangCalc.calculateTangents()
		self.lowMesh.initCalcInfoNumbers()
	
	# prints out to the console some informations
	def printInfos(self):
		if self.lowMesh.objMesh:
			print '*** Mesh Low Resolution ***'
			print 'name:    ', self.lowMesh.objMesh.data.name
			print 'textures:', len( self.lowMesh.mesh.materials )
			print 'vertices:', len( self.lowMesh.mesh.verts )
			print 'faces:   ', ( self.lowMesh.triCount + self.lowMesh.quadCount )
			print '- tris:  ', self.lowMesh.triCount
			print '- quads: ', self.lowMesh.quadCount
			print 'edges:   ', self.lowMesh.edgeCount
			print 'normals: ', self.lowMesh.normalCount
			print 'tangents:', self.lowMesh.tangentCount
		if self.hiMesh.objMesh:
			print '*** Mesh High Resolution ***'
			print 'name:    ', self.hiMesh.objMesh.data.name
			print 'vertices:', len( self.hiMesh.mesh.verts )
			print 'faces:   ', ( self.hiMesh.triCount + self.hiMesh.quadCount )
			print '- tris:  ', self.hiMesh.triCount
			print '- quads: ', self.hiMesh.quadCount
			print 'edges:   ', self.hiMesh.edgeCount
			print 'normals: ', self.hiMesh.normalCount
	
	# export file
	def export(self, filename):
		self.initExporterObjects()
		if not self.checkInitState():
			return False
		self.file = open(filename, "wb")
		try:
			result = self.safeExport()
		finally:
			self.file.close()
		self.printInfos()
		return result


# dim export class
####################
class DIMExporter ( DEBaseExporter ):
	
	# constructor
	def __init__( self, tangentCalculator ):
		DEBaseExporter.__init__( self, tangentCalculator )
	
	# title of export dialog
	def getExportTitle(self):
		return 'Export DENormGen Intermediate Mesh'
	
	# default extension for export dialog
	def getExportExtension(self):
		return 'dim'
	
	# find objects to export
	def checkInitState(self):
		if not self.lowMesh.objMesh:
			alertUser('There is no Low Resolution Mesh selected. Select a Low Resolution Mesh and a Hi Resolution Mesh', 'Error')
			return False
		if not self.hiMesh.objMesh:
			alertUser('There is no Hi Resolution Mesh selected. Select a Low Resolution Mesh and a Hi Resolution Mesh', 'Error')
			return False
		if not self.lowMesh.mesh.edges:
			self.lowMesh.mesh.addEdgesData()
		if self.lowMesh.degeneratedFaceCount > 0:
			alertUser('Degenerated Faces in low resolution mesh found.', 'Error')
			return False
		if self.hiMesh.degeneratedFaceCount > 0:
			alertUser('Degenerated Faces in high resolution mesh found.', 'Error')
			return False
		return True
	
	# write header to file
	def writeHeader( self ):
		self.file.write( 'Drag[en]gine Inter-Model' )
		return True
	
	# write low res model
	def writeLowResModel( self ):
		if debugLevel > 0:
			print ''
			print 'saving low resolution mesh...'
		# write the magic text for the low poly model
		self.file.write( 'Low-Res!' )
		# write file
		Blender.Window.DrawProgressBar( 0.0, 'Writing Low-Res Texture Informations' )
		if not self.writeLowTextures():
			return False
		Blender.Window.DrawProgressBar( 0.2, 'Writing Low-Res Vertex Informations' )
		if not self.writeLowVertices():
			return False
		Blender.Window.DrawProgressBar( 0.4, 'Writing Low-Res Tris/quads Informations' )
		if not self.writeLowTris():
			return False
		if not self.writeLowQuads():
			return False
		# we are finished
		return True
	
	# write textures
	def writeLowTextures( self ):
		if debugLevel > 0: print 'saving textures...'
		if not self.lowMesh.mesh.materials or len( self.lowMesh.mesh.materials ) == 0:
			alertUser( 'Low Resolution Mesh has no Materials', 'Error' )
			return False
		self.file.write( struct.pack( 'h', len( self.lowMesh.mesh.materials ) ) ) # count of textures
		for material in self.lowMesh.mesh.materials:
			if debugLevel > 1: print '- material', material.getName()
			# write texture
			self.file.write( struct.pack( 'b', len( material.getName() ) ) ) # len of name
			self.file.write( material.getName() ) # name
			print '- name:', material.getName()
			# find texture image to learn texture dimensions from it
			textures = material.getTextures()
			if not textures or len( textures ) == 0:
				alertUser( 'Material ' + material.getName() + ' in Low Resolution Mesh has not one texture', 'Error' )
				return False
			texture = textures[ 0 ].tex
			if texture.type != Blender.Texture.Types.IMAGE:
				alertUser( 'Texture ' + texture.getName() + ' in Material ' + material.getName() + ' in Low Resolution Mesh is not an image texture', 'Error' )
				return False
			image = texture.getImage()
			if not image:
				alertUser( 'Texture ' + texture.getName() + ' in Material ' + material.getName() + ' in Low Resolution Mesh does not have an image set', 'Error' )
				return False
			size = image.getSize()
			if size[ 0 ] < 1 or size[ 1 ] < 1:
				alertUser( 'Texture ' + texture.getName() + ' in Material ' + material.getName() + ' in Low Resolution Mesh is not of minimal 1x1 size', 'Error' )
				return False
			if debugLevel > 1: print '  - size', size[ 0 ], 'x', size[ 1 ]
			# write what we learned
			self.file.write( struct.pack( 'hh', size[ 0 ], size[ 1 ] ) ) # widht, height
		return True
	
	# write vertices
	def writeLowVertices( self ):
		if debugLevel > 0: print 'saving vertices...'
		self.file.write( struct.pack( 'h', len( self.lowMesh.vertices ) ) ) # count of vertices
		for vert in self.lowMesh.vertices:
			# verify that the vertex is used by a face
			vertIndex = vert.index
			# write position using [x,y,z]
			wpos = vector_by_matrix( transformScalePosition, vert.vertex.co )
			if debugLevel > 1: print '- vertex', vert.index, ': position', wpos.x, ',', wpos.y, ',', wpos.z
			self.file.write( struct.pack( 'fff', wpos.x, wpos.y, wpos.z ) ) # position
		# count of normals
		self.file.write( struct.pack( 'h', self.lowMesh.normalCount ) ) # count of normals
		# count of tangents
		self.file.write( struct.pack( 'h', self.lowMesh.tangentCount ) ) # count of tangents
		return True
	
	# write tris
	def writeLowTris( self ):
		if debugLevel > 0: print 'saving tris...'
		texCount = len( self.lowMesh.mesh.materials )
		self.file.write( struct.pack( 'h', self.lowMesh.triCount ) ) # count of tris
		for index in range( len( self.lowMesh.mesh.faces ) ):
			face = self.lowMesh.mesh.faces[ index ]
			deFace = self.lowMesh.faces[ index ]
			if len( face.v ) == 3:
				if debugLevel > 1: print '- tri', face.materialIndex, ':', face.v[ 0 ].index, ',', face.v[ 1 ].index, ',', face.v[ 2 ].index
				if face.materialIndex < 0 or face.materialIndex >= texCount:
					alertUser( 'Face with invalid material found (possibly not assigned to a material)', 'Error' )
					return False
				self.file.write( struct.pack( 'h', face.materialIndex ) ) # texture index
				self.file.write( struct.pack( 'hhh', face.v[ 2 ].index, face.v[ 1 ].index, face.v[ 0 ].index ) ) # position indicies
				self.file.write( struct.pack( 'hhh', deFace.normals[ 2 ], deFace.normals[ 1 ], deFace.normals[ 0 ] ) ) # normal indices
				self.file.write( struct.pack( 'hhh', deFace.tangents[ 2 ], deFace.tangents[ 1 ], deFace.tangents[ 0 ] ) ) # tangent indices
				writeTexel( self.file, face.uv[ 2 ] )
				writeTexel( self.file, face.uv[ 1 ] )
				writeTexel( self.file, face.uv[ 0 ] )
		return True
	
	# write quads
	def writeLowQuads( self ):
		if debugLevel > 0: print 'saving quads...'
		texCount = len( self.lowMesh.mesh.materials )
		self.file.write( struct.pack( 'h', self.lowMesh.quadCount ) ) # count of quads
		for index in range( len( self.lowMesh.mesh.faces ) ):
			face = self.lowMesh.mesh.faces[ index ]
			deFace = self.lowMesh.faces[ index ]
			if len( face.v ) == 4:
				if debugLevel > 1: print '- quad', face.materialIndex, ':', face.v[ 0 ].index, ',', face.v[ 1 ].index, ',', face.v[ 2 ].index, ',', face.v[ 3 ].index
				if face.materialIndex < 0 or face.materialIndex >= texCount:
					alertUser( 'Face with invalid material found (possibly not assigned to a material)', 'Error' )
					return False
				self.file.write( struct.pack( 'h', face.materialIndex ) ) # texture
				self.file.write( struct.pack( 'hhhh', face.v[ 3 ].index, face.v[ 2 ].index, face.v[ 1 ].index , face.v[ 0 ].index ) ) # position indicies
				self.file.write( struct.pack( 'hhhh', deFace.normals[ 3 ], deFace.normals[ 2 ], deFace.normals[ 1 ] , deFace.normals[ 0 ] ) ) # normal indicies
				self.file.write( struct.pack( 'hhhh', deFace.tangents[ 3 ], deFace.tangents[ 2 ], deFace.tangents[ 1 ] , deFace.tangents[ 0 ] ) ) # tangent indicies
				writeTexel( self.file, face.uv[ 3 ] )
				writeTexel( self.file, face.uv[ 2 ] )
				writeTexel( self.file, face.uv[ 1 ] )
				writeTexel( self.file, face.uv[ 0 ] )
		return True
	
	
	# write hi res model
	def writeHiResModel( self ):
		if debugLevel > 0:
			print ''
			print 'saving high resolution mesh...'
		# write the magic text for the hi poly model
		self.file.write( 'Hi-Res!@' )
		# store subdiv level
		self.file.write( struct.pack( 'h', 0 ) ) #self.hiMesh.mesh.getSubDivLevels()[1] ) ) # subdivision level
		# write file
		Blender.Window.DrawProgressBar( 0.6, 'Writing Hi-Res Vertex Informations' )
		if not self.writeHiVertices():
			return False
		Blender.Window.DrawProgressBar( 0.8, 'Writing Hi-Res Tris/quads Informations' )
		if not self.writeHiTris():
			return False
		if not self.writeHiQuads():
			return False
		# we are finished
		return True
	
	# write vertices
	def writeHiVertices( self ):
		if debugLevel > 0: print 'saving vertices...'
		self.file.write( struct.pack( 'l', len( self.hiMesh.vertices ) ) ) # count of vertices
		for vert in self.hiMesh.vertices:
			# verify that the vertex is used by a face
			vertIndex = vert.index
			# write position using [x,y,z]
			wpos = vector_by_matrix( transformScalePosition, vert.vertex.co )
			if debugLevel > 1: print '- vertex', vert.index, ': position', wpos.x, ',', wpos.y, ',', wpos.z
			self.file.write( struct.pack( 'fff', wpos.x, wpos.y, wpos.z ) ) # position
		# count of normals
		self.file.write( struct.pack( 'l', self.hiMesh.normalCount ) ) # count of normals
		return True
	
	# write tris vertices only
	def writeHiTris( self ):
		if debugLevel > 0: print 'saving tris...'
		self.file.write( struct.pack( 'l', self.hiMesh.triCount ) ) # count of tris
		for index in range( len( self.hiMesh.mesh.faces ) ):
			face = self.hiMesh.mesh.faces[ index ]
			deFace = self.hiMesh.faces[ index ]
			if len( face.v ) == 3:
				if debugLevel > 1: print '- tri :', face.v[0].index, ',', face.v[1].index, ',', face.v[2].index
				self.file.write( struct.pack( 'lll', face.v[2].index, face.v[1].index, face.v[0].index ) )
				self.file.write( struct.pack( 'lll', deFace.normals[ 2 ], deFace.normals[ 1 ], deFace.normals[ 0 ] ) ) # normal indices
		return True
	
	# write quads vertices only
	def writeHiQuads( self ):
		if debugLevel > 0: print 'saving quads...'
		self.file.write( struct.pack( 'l', self.hiMesh.quadCount ) ) # count of quads
		for index in range( len( self.hiMesh.mesh.faces ) ):
			face = self.hiMesh.mesh.faces[ index ]
			deFace = self.hiMesh.faces[ index ]
			if len( face.v ) == 4:
				if debugLevel > 1: print '- quad :', face.v[0].index, ',', face.v[1].index, ',', face.v[2].index, ',', face.v[3].index
				self.file.write( struct.pack( 'llll', face.v[3].index, face.v[2].index, face.v[1].index , face.v[0].index) )
				self.file.write( struct.pack( 'llll', deFace.normals[ 3 ], deFace.normals[ 2 ], deFace.normals[ 1 ] , deFace.normals[ 0 ] ) ) # normal indicies
		return True
	
	
	# protected export to file function
	def safeExport( self ):
		# write file
		if not self.writeHeader():
			return False
		if not self.writeLowResModel():
			return False
		if not self.writeHiResModel():
			return False
		Blender.Window.DrawProgressBar( 1.0, 'Finished' )
		return True	



# output debugging informations
def outputDebug(message):
	Blender.Draw.PupMenu('Drag[en]gine Export Debug%t|' + message)

# alert user of something
def alertUser(message, title):
	Blender.Draw.PupMenu('Drag[en]gine Export ' + title + '%t|' + message)



# helper function for writing texel positions
# texel is here an array of two floats in
# blender coordinates.
def writeTexel( file, texel ):
	file.write( struct.pack( 'ff', texel[ 0 ], 1.0 - texel[ 1 ] ) )

# helper function to transform a vector by a matrix
def vector_by_matrix( m, p ):
  return Vector( [ p[0] * m[0][0] + p[1] * m[1][0] + p[2] * m[2][0] + m[3][0],
          p[0] * m[0][1] + p[1] * m[1][1] + p[2] * m[2][1] + m[3][1],
          p[0] * m[0][2] + p[1] * m[1][2] + p[2] * m[2][2] + m[3][2] ] )

# helper function to check if two uv coordinates are equal
############################################################
def texelEquals( texel1, texel2 ):
	if abs( texel1[ 0 ] - texel2[ 0 ] ) > 0.0001:
		return False
	elif abs( texel1[ 1 ] - texel2[ 1 ] ) > 0.0001:
		return False
	return True



# callback for the file dialog
def fileDialogCallback( filename ):
	if not filename.endswith( '.' + exporter.getExportExtension() ):
		filename = filename + '.' + exporter.getExportExtension()
	exporter.export( filename )

# create a filename that is matching our file format
def newFName():
	filename = Blender.Get( 'filename' )
	#if filename.endswith( exporter.getExportExtension() ):
	#	return filename
	#else:
	#	return filename + exporter.getExportExtension()
	return Blender.Get( 'filename' )[: -len(Blender.Get( 'filename' ).split( '.', -1 )[ -1 ] ) ] + exporter.getExportExtension()
	#return Blender.Get('filename')[: -len(Blender.Get('filename').split('.', -1)[-1]) ] + exporter.getExportExtension()



# debugging informations
# 0 = no debug infos
# 1 = a bit of debug infos
# 2 = even more debug infos
# 3 = heavy debug infos, makes your console to explode ;=)
debugLevel = 1

# entry point.
#args = __script__['arg']
#if args == 'export_model':
selTangCalc = Blender.Draw.PupMenu( 'Select Tangent Calculator%t|Copy Normals|UV-Splitter' )
if selTangCalc == 1:
	tangCalc = DIMTCCopyNormal()
else:
	tangCalc = DIMTCUVSplitter()

exporter = DIMExporter( tangCalc )
Blender.Window.FileSelector( fileDialogCallback, exporter.getExportTitle(), newFName() )
#else:
#	alertUser('Now I am confuzzled. What shall I do with \'%s\'?!' % (args), 'Error')
