-----------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Rendering.OpenGL.GL.Shaders.ShaderBinaries
-- Copyright   :  (c) Sven Panne 2006-2013
-- License     :  BSD3
--
-- Maintainer  :  Sven Panne <svenpanne@gmail.com>
-- Stability   :  stable
-- Portability :  portable
--
-- This module corresponds to section 7.2 (Shader Binaries) of the OpenGL 4.4
-- spec.
--
-----------------------------------------------------------------------------

module Graphics.Rendering.OpenGL.GL.Shaders.ShaderBinaries (
   ShaderBinaryFormat(..), shaderBinaryFormats,
   ShaderBinary(..), shaderBinary,
) where

import Foreign.Marshal.Array
import Foreign.Ptr
import Graphics.Rendering.OpenGL.GL.QueryUtils
import Graphics.Rendering.OpenGL.GL.Shaders.Shader
import Graphics.Rendering.OpenGL.GL.StateVar
import Graphics.Rendering.OpenGL.Raw.ARB.ES2Compatibility
import Graphics.Rendering.OpenGL.Raw.Core31

--------------------------------------------------------------------------------

newtype ShaderBinaryFormat = ShaderBinaryFormat GLenum
   deriving ( Eq, Ord, Show )

shaderBinaryFormats :: GettableStateVar [ShaderBinaryFormat]
shaderBinaryFormats =
   makeGettableStateVar $ do
      n <- getInteger1 fromIntegral GetNumShaderBinaryFormats
      getEnumN ShaderBinaryFormat GetShaderBinaryFormats n

data ShaderBinary a = ShaderBinary ShaderBinaryFormat (Ptr a) GLsizei
   deriving ( Eq, Ord, Show )

shaderBinary :: [Shader] -> ShaderBinary a -> IO ()
shaderBinary shaders (ShaderBinary (ShaderBinaryFormat format) ptr size) =
   withArrayLen (map shaderID shaders) $ \numShaders shadersBuf ->
      glShaderBinary (fromIntegral numShaders) shadersBuf format ptr size
