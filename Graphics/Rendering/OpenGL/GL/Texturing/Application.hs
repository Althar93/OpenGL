--------------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Rendering.OpenGL.GL.Texturing.Application
-- Copyright   :  (c) Sven Panne 2002-2013
-- License     :  BSD3
-- 
-- Maintainer  :  Sven Panne <svenpanne@gmail.com>
-- Stability   :  stable
-- Portability :  portable
--
-- This module corresponds to section 3.8.15 (Texture Application) of the
-- OpenGL 2.1 specs.
--
--------------------------------------------------------------------------------

module Graphics.Rendering.OpenGL.GL.Texturing.Application (
   texture
) where

import Graphics.Rendering.OpenGL.GL.StateVar
import Graphics.Rendering.OpenGL.GL.Capability
import Graphics.Rendering.OpenGL.GL.Texturing.Specification

--------------------------------------------------------------------------------

-- ToDo: cube maps
texture :: TextureTarget -> StateVar Capability
texture = makeCapability . textureTargetToEnableCap

textureTargetToEnableCap :: TextureTarget -> EnableCap
textureTargetToEnableCap x = case x of
    Texture1D -> CapTexture1D
    Texture2D -> CapTexture2D
    Texture3D -> CapTexture3D
    TextureCubeMap -> CapTextureCubeMap
    TextureRectangle -> CapTextureRectangle
