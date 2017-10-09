{- This file was auto-generated from tensorflow/core/framework/graph.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Tensorflow.Core.Framework.Graph where
import qualified Data.ProtoLens.Reexport.Prelude as Prelude
import qualified Data.ProtoLens.Reexport.Data.Int as Data.Int
import qualified Data.ProtoLens.Reexport.Data.Word as Data.Word
import qualified Data.ProtoLens.Reexport.Data.ProtoLens
       as Data.ProtoLens
import qualified
       Data.ProtoLens.Reexport.Data.ProtoLens.Message.Enum
       as Data.ProtoLens.Message.Enum
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
import qualified Data.ProtoLens.Reexport.Lens.Labels as Lens.Labels
import qualified Proto.Tensorflow.Core.Framework.NodeDef

data GraphDef = GraphDef{_GraphDef'node ::
                         ![Proto.Tensorflow.Core.Framework.NodeDef.NodeDef]}
              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Proto.Tensorflow.Core.Framework.NodeDef.NodeDef],
          b ~ [Proto.Tensorflow.Core.Framework.NodeDef.NodeDef],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "node" f GraphDef GraphDef a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _GraphDef'node
                 (\ x__ y__ -> x__{_GraphDef'node = y__}))
              Prelude.id

instance Data.Default.Class.Default GraphDef where
        def = GraphDef{_GraphDef'node = []}

instance Data.ProtoLens.Message GraphDef where
        descriptor
          = let node__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "node"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.NodeDef.NodeDef)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked node)
                      :: Data.ProtoLens.FieldDescriptor GraphDef
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "tensorflow.GraphDef")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, node__field_descriptor)])
                (Data.Map.fromList [("node", node__field_descriptor)])

node ::
     forall f s t a b . Lens.Labels.HasLens "node" f s t a b =>
       Lens.Family2.LensLike f s t a b
node
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "node")