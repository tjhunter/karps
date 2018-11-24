{- This file was auto-generated from karps/proto/graph.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies,
  UndecidableInstances, MultiParamTypeClasses, FlexibleContexts,
  FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude
  #-}
{-# OPTIONS_GHC -fno-warn-unused-imports #-}
module Proto.Karps.Proto.Graph where
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
import qualified Proto.Karps.Proto.Types
import qualified Proto.Tensorflow.Core.Framework.Graph

data CompilationPhaseGraph = CompilationPhaseGraph{_CompilationPhaseGraph'phaseName
                                                   :: !Data.Text.Text,
                                                   _CompilationPhaseGraph'graph ::
                                                   !(Prelude.Maybe Graph),
                                                   _CompilationPhaseGraph'graphTensorboardRepr ::
                                                   !Data.Text.Text,
                                                   _CompilationPhaseGraph'errorMessage ::
                                                   !Data.Text.Text,
                                                   _CompilationPhaseGraph'graphDef ::
                                                   !(Prelude.Maybe
                                                       Proto.Tensorflow.Core.Framework.Graph.GraphDef)}
                           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "phaseName" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'phaseName
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'phaseName = y__}))
              Prelude.id

instance (a ~ Graph, b ~ Graph, Prelude.Functor f) =>
         Lens.Labels.HasLens "graph" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graph
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graph = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Graph, b ~ Prelude.Maybe Graph,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'graph" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graph
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graph = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "graphTensorboardRepr" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens
                 _CompilationPhaseGraph'graphTensorboardRepr
                 (\ x__ y__ ->
                    x__{_CompilationPhaseGraph'graphTensorboardRepr = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "errorMessage" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'errorMessage
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'errorMessage = y__}))
              Prelude.id

instance (a ~ Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          b ~ Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "graphDef" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graphDef
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graphDef = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~
            Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          b ~ Prelude.Maybe Proto.Tensorflow.Core.Framework.Graph.GraphDef,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'graphDef" f CompilationPhaseGraph
         CompilationPhaseGraph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _CompilationPhaseGraph'graphDef
                 (\ x__ y__ -> x__{_CompilationPhaseGraph'graphDef = y__}))
              Prelude.id

instance Data.Default.Class.Default CompilationPhaseGraph where
        def
          = CompilationPhaseGraph{_CompilationPhaseGraph'phaseName =
                                    Data.ProtoLens.fieldDefault,
                                  _CompilationPhaseGraph'graph = Prelude.Nothing,
                                  _CompilationPhaseGraph'graphTensorboardRepr =
                                    Data.ProtoLens.fieldDefault,
                                  _CompilationPhaseGraph'errorMessage = Data.ProtoLens.fieldDefault,
                                  _CompilationPhaseGraph'graphDef = Prelude.Nothing}

instance Data.ProtoLens.Message CompilationPhaseGraph where
        descriptor
          = let phaseName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "phase_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional phaseName)
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                graph__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Graph)
                      (Data.ProtoLens.OptionalField maybe'graph)
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                graphTensorboardRepr__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph_tensorboard_repr"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional
                         graphTensorboardRepr)
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                errorMessage__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "error_message"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional errorMessage)
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
                graphDef__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "graph_def"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor
                           Proto.Tensorflow.Core.Framework.Graph.GraphDef)
                      (Data.ProtoLens.OptionalField maybe'graphDef)
                      :: Data.ProtoLens.FieldDescriptor CompilationPhaseGraph
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.CompilationPhaseGraph")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, phaseName__field_descriptor),
                    (Data.ProtoLens.Tag 2, graph__field_descriptor),
                    (Data.ProtoLens.Tag 3, graphTensorboardRepr__field_descriptor),
                    (Data.ProtoLens.Tag 4, errorMessage__field_descriptor),
                    (Data.ProtoLens.Tag 5, graphDef__field_descriptor)])
                (Data.Map.fromList
                   [("phase_name", phaseName__field_descriptor),
                    ("graph", graph__field_descriptor),
                    ("graph_tensorboard_repr", graphTensorboardRepr__field_descriptor),
                    ("error_message", errorMessage__field_descriptor),
                    ("graph_def", graphDef__field_descriptor)])

data Graph = Graph{_Graph'nodes :: ![Node]}
           deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Node], b ~ [Node], Prelude.Functor f) =>
         Lens.Labels.HasLens "nodes" f Graph Graph a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Graph'nodes
                 (\ x__ y__ -> x__{_Graph'nodes = y__}))
              Prelude.id

instance Data.Default.Class.Default Graph where
        def = Graph{_Graph'nodes = []}

instance Data.ProtoLens.Message Graph where
        descriptor
          = let nodes__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "nodes"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Node)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked nodes)
                      :: Data.ProtoLens.FieldDescriptor Graph
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.Graph")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, nodes__field_descriptor)])
                (Data.Map.fromList [("nodes", nodes__field_descriptor)])

data Locality = LOCAL
              | DISTRIBUTED
              deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance Data.Default.Class.Default Locality where
        def = LOCAL

instance Data.ProtoLens.FieldDefault Locality where
        fieldDefault = LOCAL

instance Data.ProtoLens.MessageEnum Locality where
        maybeToEnum 0 = Prelude.Just LOCAL
        maybeToEnum 1 = Prelude.Just DISTRIBUTED
        maybeToEnum _ = Prelude.Nothing
        showEnum LOCAL = "LOCAL"
        showEnum DISTRIBUTED = "DISTRIBUTED"
        readEnum "LOCAL" = Prelude.Just LOCAL
        readEnum "DISTRIBUTED" = Prelude.Just DISTRIBUTED
        readEnum _ = Prelude.Nothing

instance Prelude.Enum Locality where
        toEnum k__
          = Prelude.maybe
              (Prelude.error
                 ((Prelude.++) "toEnum: unknown value for enum Locality: "
                    (Prelude.show k__)))
              Prelude.id
              (Data.ProtoLens.maybeToEnum k__)
        fromEnum LOCAL = 0
        fromEnum DISTRIBUTED = 1
        succ DISTRIBUTED
          = Prelude.error
              "Locality.succ: bad argument DISTRIBUTED. This value would be out of bounds."
        succ LOCAL = DISTRIBUTED
        pred LOCAL
          = Prelude.error
              "Locality.pred: bad argument LOCAL. This value would be out of bounds."
        pred DISTRIBUTED = LOCAL
        enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
        enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
        enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
        enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo

instance Prelude.Bounded Locality where
        minBound = LOCAL
        maxBound = DISTRIBUTED

data Node = Node{_Node'locality :: !Locality,
                 _Node'path :: !(Prelude.Maybe Path),
                 _Node'opName :: !Data.Text.Text,
                 _Node'opExtra :: !(Prelude.Maybe OpExtra),
                 _Node'parents :: ![Path], _Node'logicalDependencies :: ![Path],
                 _Node'inferedType ::
                 !(Prelude.Maybe Proto.Karps.Proto.Types.SQLType)}
          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Locality, b ~ Locality, Prelude.Functor f) =>
         Lens.Labels.HasLens "locality" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'locality
                 (\ x__ y__ -> x__{_Node'locality = y__}))
              Prelude.id

instance (a ~ Path, b ~ Path, Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'path
                 (\ x__ y__ -> x__{_Node'path = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Path, b ~ Prelude.Maybe Path,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'path" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'path
                 (\ x__ y__ -> x__{_Node'path = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "opName" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'opName
                 (\ x__ y__ -> x__{_Node'opName = y__}))
              Prelude.id

instance (a ~ OpExtra, b ~ OpExtra, Prelude.Functor f) =>
         Lens.Labels.HasLens "opExtra" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'opExtra
                 (\ x__ y__ -> x__{_Node'opExtra = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe OpExtra, b ~ Prelude.Maybe OpExtra,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'opExtra" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'opExtra
                 (\ x__ y__ -> x__{_Node'opExtra = y__}))
              Prelude.id

instance (a ~ [Path], b ~ [Path], Prelude.Functor f) =>
         Lens.Labels.HasLens "parents" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'parents
                 (\ x__ y__ -> x__{_Node'parents = y__}))
              Prelude.id

instance (a ~ [Path], b ~ [Path], Prelude.Functor f) =>
         Lens.Labels.HasLens "logicalDependencies" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'logicalDependencies
                 (\ x__ y__ -> x__{_Node'logicalDependencies = y__}))
              Prelude.id

instance (a ~ Proto.Karps.Proto.Types.SQLType,
          b ~ Proto.Karps.Proto.Types.SQLType, Prelude.Functor f) =>
         Lens.Labels.HasLens "inferedType" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'inferedType
                 (\ x__ y__ -> x__{_Node'inferedType = y__}))
              (Data.ProtoLens.maybeLens Data.Default.Class.def)

instance (a ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          b ~ Prelude.Maybe Proto.Karps.Proto.Types.SQLType,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "maybe'inferedType" f Node Node a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Node'inferedType
                 (\ x__ y__ -> x__{_Node'inferedType = y__}))
              Prelude.id

instance Data.Default.Class.Default Node where
        def
          = Node{_Node'locality = Data.Default.Class.def,
                 _Node'path = Prelude.Nothing,
                 _Node'opName = Data.ProtoLens.fieldDefault,
                 _Node'opExtra = Prelude.Nothing, _Node'parents = [],
                 _Node'logicalDependencies = [],
                 _Node'inferedType = Prelude.Nothing}

instance Data.ProtoLens.Message Node where
        descriptor
          = let locality__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "locality"
                      (Data.ProtoLens.EnumField ::
                         Data.ProtoLens.FieldTypeDescriptor Locality)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional locality)
                      :: Data.ProtoLens.FieldDescriptor Node
                path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Path)
                      (Data.ProtoLens.OptionalField maybe'path)
                      :: Data.ProtoLens.FieldDescriptor Node
                opName__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op_name"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional opName)
                      :: Data.ProtoLens.FieldDescriptor Node
                opExtra__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "op_extra"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor OpExtra)
                      (Data.ProtoLens.OptionalField maybe'opExtra)
                      :: Data.ProtoLens.FieldDescriptor Node
                parents__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "parents"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked parents)
                      :: Data.ProtoLens.FieldDescriptor Node
                logicalDependencies__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "logical_dependencies"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Path)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked
                         logicalDependencies)
                      :: Data.ProtoLens.FieldDescriptor Node
                inferedType__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "infered_type"
                      (Data.ProtoLens.MessageField ::
                         Data.ProtoLens.FieldTypeDescriptor Proto.Karps.Proto.Types.SQLType)
                      (Data.ProtoLens.OptionalField maybe'inferedType)
                      :: Data.ProtoLens.FieldDescriptor Node
              in
              Data.ProtoLens.MessageDescriptor (Data.Text.pack "karps.core.Node")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, locality__field_descriptor),
                    (Data.ProtoLens.Tag 2, path__field_descriptor),
                    (Data.ProtoLens.Tag 3, opName__field_descriptor),
                    (Data.ProtoLens.Tag 4, opExtra__field_descriptor),
                    (Data.ProtoLens.Tag 5, parents__field_descriptor),
                    (Data.ProtoLens.Tag 6, logicalDependencies__field_descriptor),
                    (Data.ProtoLens.Tag 7, inferedType__field_descriptor)])
                (Data.Map.fromList
                   [("locality", locality__field_descriptor),
                    ("path", path__field_descriptor),
                    ("op_name", opName__field_descriptor),
                    ("op_extra", opExtra__field_descriptor),
                    ("parents", parents__field_descriptor),
                    ("logical_dependencies", logicalDependencies__field_descriptor),
                    ("infered_type", inferedType__field_descriptor)])

data OpExtra = OpExtra{_OpExtra'content ::
                       !Data.ByteString.ByteString,
                       _OpExtra'contentDebug :: !Data.Text.Text,
                       _OpExtra'contentBase64 :: !Data.Text.Text}
             deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ Data.ByteString.ByteString,
          b ~ Data.ByteString.ByteString, Prelude.Functor f) =>
         Lens.Labels.HasLens "content" f OpExtra OpExtra a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _OpExtra'content
                 (\ x__ y__ -> x__{_OpExtra'content = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "contentDebug" f OpExtra OpExtra a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _OpExtra'contentDebug
                 (\ x__ y__ -> x__{_OpExtra'contentDebug = y__}))
              Prelude.id

instance (a ~ Data.Text.Text, b ~ Data.Text.Text,
          Prelude.Functor f) =>
         Lens.Labels.HasLens "contentBase64" f OpExtra OpExtra a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _OpExtra'contentBase64
                 (\ x__ y__ -> x__{_OpExtra'contentBase64 = y__}))
              Prelude.id

instance Data.Default.Class.Default OpExtra where
        def
          = OpExtra{_OpExtra'content = Data.ProtoLens.fieldDefault,
                    _OpExtra'contentDebug = Data.ProtoLens.fieldDefault,
                    _OpExtra'contentBase64 = Data.ProtoLens.fieldDefault}

instance Data.ProtoLens.Message OpExtra where
        descriptor
          = let content__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content"
                      (Data.ProtoLens.BytesField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.ByteString.ByteString)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional content)
                      :: Data.ProtoLens.FieldDescriptor OpExtra
                contentDebug__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content_debug"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional contentDebug)
                      :: Data.ProtoLens.FieldDescriptor OpExtra
                contentBase64__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "content_base64"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.PlainField Data.ProtoLens.Optional contentBase64)
                      :: Data.ProtoLens.FieldDescriptor OpExtra
              in
              Data.ProtoLens.MessageDescriptor
                (Data.Text.pack "karps.core.OpExtra")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, content__field_descriptor),
                    (Data.ProtoLens.Tag 2, contentDebug__field_descriptor),
                    (Data.ProtoLens.Tag 3, contentBase64__field_descriptor)])
                (Data.Map.fromList
                   [("content", content__field_descriptor),
                    ("content_debug", contentDebug__field_descriptor),
                    ("content_base64", contentBase64__field_descriptor)])

data Path = Path{_Path'path :: ![Data.Text.Text]}
          deriving (Prelude.Show, Prelude.Eq, Prelude.Ord)

instance (a ~ [Data.Text.Text], b ~ [Data.Text.Text],
          Prelude.Functor f) =>
         Lens.Labels.HasLens "path" f Path Path a b where
        lensOf _
          = (Prelude..)
              (Lens.Family2.Unchecked.lens _Path'path
                 (\ x__ y__ -> x__{_Path'path = y__}))
              Prelude.id

instance Data.Default.Class.Default Path where
        def = Path{_Path'path = []}

instance Data.ProtoLens.Message Path where
        descriptor
          = let path__field_descriptor
                  = Data.ProtoLens.FieldDescriptor "path"
                      (Data.ProtoLens.StringField ::
                         Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
                      (Data.ProtoLens.RepeatedField Data.ProtoLens.Unpacked path)
                      :: Data.ProtoLens.FieldDescriptor Path
              in
              Data.ProtoLens.MessageDescriptor (Data.Text.pack "karps.core.Path")
                (Data.Map.fromList
                   [(Data.ProtoLens.Tag 1, path__field_descriptor)])
                (Data.Map.fromList [("path", path__field_descriptor)])

content ::
        forall f s t a b . Lens.Labels.HasLens "content" f s t a b =>
          Lens.Family2.LensLike f s t a b
content
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "content")

contentBase64 ::
              forall f s t a b . Lens.Labels.HasLens "contentBase64" f s t a b =>
                Lens.Family2.LensLike f s t a b
contentBase64
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "contentBase64")

contentDebug ::
             forall f s t a b . Lens.Labels.HasLens "contentDebug" f s t a b =>
               Lens.Family2.LensLike f s t a b
contentDebug
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "contentDebug")

errorMessage ::
             forall f s t a b . Lens.Labels.HasLens "errorMessage" f s t a b =>
               Lens.Family2.LensLike f s t a b
errorMessage
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "errorMessage")

graph ::
      forall f s t a b . Lens.Labels.HasLens "graph" f s t a b =>
        Lens.Family2.LensLike f s t a b
graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graph")

graphDef ::
         forall f s t a b . Lens.Labels.HasLens "graphDef" f s t a b =>
           Lens.Family2.LensLike f s t a b
graphDef
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "graphDef")

graphTensorboardRepr ::
                     forall f s t a b .
                       Lens.Labels.HasLens "graphTensorboardRepr" f s t a b =>
                       Lens.Family2.LensLike f s t a b
graphTensorboardRepr
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "graphTensorboardRepr")

inferedType ::
            forall f s t a b . Lens.Labels.HasLens "inferedType" f s t a b =>
              Lens.Family2.LensLike f s t a b
inferedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "inferedType")

locality ::
         forall f s t a b . Lens.Labels.HasLens "locality" f s t a b =>
           Lens.Family2.LensLike f s t a b
locality
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "locality")

logicalDependencies ::
                    forall f s t a b .
                      Lens.Labels.HasLens "logicalDependencies" f s t a b =>
                      Lens.Family2.LensLike f s t a b
logicalDependencies
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) ::
         (Lens.Labels.Proxy#) "logicalDependencies")

maybe'graph ::
            forall f s t a b . Lens.Labels.HasLens "maybe'graph" f s t a b =>
              Lens.Family2.LensLike f s t a b
maybe'graph
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graph")

maybe'graphDef ::
               forall f s t a b .
                 Lens.Labels.HasLens "maybe'graphDef" f s t a b =>
                 Lens.Family2.LensLike f s t a b
maybe'graphDef
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'graphDef")

maybe'inferedType ::
                  forall f s t a b .
                    Lens.Labels.HasLens "maybe'inferedType" f s t a b =>
                    Lens.Family2.LensLike f s t a b
maybe'inferedType
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'inferedType")

maybe'opExtra ::
              forall f s t a b . Lens.Labels.HasLens "maybe'opExtra" f s t a b =>
                Lens.Family2.LensLike f s t a b
maybe'opExtra
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'opExtra")

maybe'path ::
           forall f s t a b . Lens.Labels.HasLens "maybe'path" f s t a b =>
             Lens.Family2.LensLike f s t a b
maybe'path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "maybe'path")

nodes ::
      forall f s t a b . Lens.Labels.HasLens "nodes" f s t a b =>
        Lens.Family2.LensLike f s t a b
nodes
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "nodes")

opExtra ::
        forall f s t a b . Lens.Labels.HasLens "opExtra" f s t a b =>
          Lens.Family2.LensLike f s t a b
opExtra
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opExtra")

opName ::
       forall f s t a b . Lens.Labels.HasLens "opName" f s t a b =>
         Lens.Family2.LensLike f s t a b
opName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "opName")

parents ::
        forall f s t a b . Lens.Labels.HasLens "parents" f s t a b =>
          Lens.Family2.LensLike f s t a b
parents
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "parents")

path ::
     forall f s t a b . Lens.Labels.HasLens "path" f s t a b =>
       Lens.Family2.LensLike f s t a b
path
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "path")

phaseName ::
          forall f s t a b . Lens.Labels.HasLens "phaseName" f s t a b =>
            Lens.Family2.LensLike f s t a b
phaseName
  = Lens.Labels.lensOf
      ((Lens.Labels.proxy#) :: (Lens.Labels.Proxy#) "phaseName")