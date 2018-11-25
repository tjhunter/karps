{- This file was auto-generated from tensorflow/core/framework/graph.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, GeneralizedNewtypeDeriving,
  MultiParamTypeClasses, FlexibleContexts, FlexibleInstances,
  PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds #-}
{-# OPTIONS_GHC -fno-warn-unused-imports#-}
{-# OPTIONS_GHC -fno-warn-duplicate-exports#-}
module Proto.Tensorflow.Core.Framework.Graph (GraphDef(..)) where
import qualified Data.ProtoLens.Reexport.Lens.Labels.Prism
       as Lens.Labels.Prism
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Service.Types
       as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Reexport.Lens.Family2
       as Lens.Family2
import qualified Data.ProtoLens.Reexport.Lens.Family2.Unchecked
       as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Reexport.Data.Default.Class
       as Data.Default.Class
import qualified Data.ProtoLens.Reexport.Data.Text as Data.Text
import qualified Data.ProtoLens.Reexport.Data.Map as Data.Map
import qualified Data.ProtoLens.Reexport.Data.ByteString
       as Data.ByteString
import qualified Data.ProtoLens.Reexport.Data.ByteString.Char8
       as Data.ByteString.Char8
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels
import qualified Data.ProtoLens.Reexport.Text.Read as Text.Read
import qualified Proto.Tensorflow.Core.Framework.NodeDef

{- | Fields :

    * 'Proto.Tensorflow.Core.Framework.Graph_Fields.node' @:: Lens' GraphDef [Proto.Tensorflow.Core.Framework.NodeDef.NodeDef]@
 -}
data GraphDef = GraphDef{_GraphDef'node ::
                         ![Proto.Tensorflow.Core.Framework.NodeDef.NodeDef],
                         _GraphDef'_unknownFields :: !Data.ProtoLens.FieldSet}
                  deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance (Lens.Labels.HasLens' f GraphDef x a, a ~ b) =>
         Lens.Labels.HasLens f GraphDef GraphDef x a b
         where
        lensOf = Lens.Labels.lensOf'
instance Prelude.Functor f =>
         Lens.Labels.HasLens' f GraphDef "node"
           ([Proto.Tensorflow.Core.Framework.NodeDef.NodeDef])
         where
        lensOf' _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphDef'node
                 (\ x__ y__ -> x__{_GraphDef'node = y__}))
              Prelude.id
instance Data.Default.Class.Default GraphDef where
        def
          = GraphDef{_GraphDef'node = [], _GraphDef'_unknownFields = ([])}
instance Data.ProtoLens.Message GraphDef where
        messageName _ = Data.Text.pack "tensorflow.GraphDef"
        fieldsByTag
          = let node__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "node"
                      (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         (Lens.Labels.lensOf
                            ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "node")))
                      :: Data.ProtoLens.FieldDescriptor GraphDef
              in
              Data.Map.fromList [(Data.ProtoLens.Tag 1, node__field_descriptor)]
        unknownFields
          = Lens.Family2.Unchecked.lens _GraphDef'_unknownFields
              (\ x__ y__ -> x__{_GraphDef'_unknownFields = y__})